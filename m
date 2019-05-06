Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F2B14849
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEFKUk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 06:20:40 -0400
Received: from 0.ictbs.com ([203.137.112.168]:54023 "EHLO 0.ictbs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfEFKUk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 06:20:40 -0400
Received: by hq.local (Postfix, from userid 1000)
        id E57FF66429; Mon,  6 May 2019 12:20:32 +0200 (CEST)
Date:   Mon, 6 May 2019 12:20:32 +0200
From:   Victor Bravo <1905@spmblk.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
Message-ID: <20190506102032.3ximjecado4mz62j@localhost>
References: <20190504162633.ldrz2nqfocg55grb@localhost>
 <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
 <20190504194440.4zcxjrtj2aft3ka4@localhost>
 <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20190505150355.3fbng4ny34x255vk@localhost>
 <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com>
 <20190506090609.msudhncj7e5vdtzw@localhost>
 <70677dff-4336-28d5-7ab9-7ba7c3d74ebc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70677dff-4336-28d5-7ab9-7ba7c3d74ebc@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 06, 2019 at 11:33:20AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 06-05-19 11:06, Victor Bravo wrote:
> > On Mon, May 06, 2019 at 10:13:38AM +0200, Hans de Goede wrote:
> > > Hi,
> > 
> > Hi,
> > 
> > > On 05-05-19 17:03, Victor Bravo wrote:
> > > > Sanitize DMI strings in brcmfmac driver to make resulting filenames
> > > > contain only safe characters. This version replaces all non-printable
> > > > characters incl. delete (0-31, 127-255), spaces and slashes with
> > > > underscores.
> > > > 
> > > > This change breaks backward compatibility, but adds control over strings
> > > > passed to firmware loader and compatibility with CONFIG_EXTRA_FIRMWARE
> > > > which doesn't support spaces in filenames.
> > > > 
> > > > Changes from v1: don't revert fresh commit by someone else
> > > > 
> > > > Signed-off-by: Victor Bravo <1905@spmblk.com>
> > > 
> > > Thank you for the patch, but I'm sorry to say this patch cannot go in as is,
> > > because it will break existing systems.
> > > 
> > > If you look here:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/brcm
> > > 
> > > You will see a file named: "brcmfmac43430a0-sdio.ONDA-V80 PLUS.txt" there, which
> > > has a space in its name (and which works fine).
> > 
> > Thanks for the updates. Spaces are actually a problem as files with spaces
> > don't work when built-in with CONFIG_EXTRA_FIRMWARE (which is used with
> > non-modular kernel containing brcmfmac driver).
> > 
> > If the DMI string contains slashes, they will cause problems
> > for obvious reasons too.
> 
> Right, as said I'm fine with sanitizing the names, so dropping e.g. / chars,
> but replacing space with _ will cause wifi to stop working on Onda V80 Plus devices and
> we have a clear no regressions policy in the kernel.

Please keep in mind that dropping slashes and non-printable characters
might be a regression too, as some users may already be using
intermediate directories or filenames with tabs etc. if their DMI
strings contain these.  If such users exist, they will have to rename
their nvram files anyway.

On the other hand, removing just slashes and non-printable characters
(i.e. (*dst < 0x20) || (dst == '/') || (dst == 0x7f)) would allow
the sanitize function to the bit array and go with hardcoded conditions
(especially if those are final and won't need further adjustments in
set of allowed characters

> > > I'm fine with doing some sanitizing of the strings, but replacing spaces with _
> > > breaks existing use-cases (will cause a regression for them) and a space is absolutely
> > > a valid character in a filename and the firmware-loader can deal with this just fine.
> > > 
> > > If the code for building firmwares into the kernel cannot deal with spaces then IMHO
> > > that code should be fixed instead. Have you looked into fixing that?
> > 
> > Yes, but updating CONFIG_EXTRA_FIRMWARE to support spaces because of
> > this looks much like
> 
> <snip off-topic remark>
> 
> > Do you really think it's a good idea to propose that in
> > this case?
> 
> I think expecting spaces in filenames to just work is quite reasonable, after all
> its been a long time since we've left DOS-es 8.3 filename limitations.
> 
> Have you actually looked at how hard it would be to make filenames with spaces work
> with CONFIG_EXTRA_FIRMWARE ?
> 
> No matter how you spin it, the space problem is a CONFIG_EXTRA_FIRMWARE bug, not an
> issue with the brcmfmac code.

Well CONFIG_EXTRA_FIRMWARE is defined to use space as filename
separator, so I don't really dare to call that a bug. Also brcmfmac
seems to be only driver requiring support for spaces etc. in firmware
file names, and this requirement seems to be quite fresh.

So to me the proper way to fix this via CONFIG_EXTRA_FIRMWARE seems to
be

1) wait some time until brcfmac's fw filenames with spaces become
de-facto standard and distros are literally full of these.

2) after this happens, propose update of CONFIG_EXTRA_FIRMWARE to
support spaces in filenames, arguing with status quo which coming from 1)

Unfortunately I feel more like a programmer and this seems more like
politics, so I can promise participation in the wait part only right
now.

> > > As for your T100HA example from earlier in this thread, the brcmfmac driver now
> > > also supports getting the firmware from a special EFI nvram variable, which the
> > > T100HA sets, so you do not need to provide a nvram file on the T100HA and things
> > > will still work.
> > 
> > I don't really get this. Can you please suggest how do I make the driver
> > use something different than "brcmfmac43340-sdio.txt" or
> > "brcmfmac43340-sdio.ASUSTeK COMPUTER INC.-T100HAN.txt" on T100HAN?
> 
> If you leave out either file, then with a recent kernel you should see this
> brcm_info trigger:
> 
>         brcmf_info("Using nvram EFI variable\n");
> 
> So you should see this message when you do:
> 
> dmesg | grep "Using nvram EFI variable"
> 
> And the wifi on the T100HAN should just work, without needing to do any
> manual config / provide an nvram file in anyway.
> 
> I always strive to make hardware just work with Linux and any UEFI x86 machine
> using brcmfmac which provides the necessary nvram EFI variable in its firmware
> should now just work when booting say a Fedora 30 livecd.
> 
> The EFI nvram var support has been tested successfully on the following models:
> 
> Acer Iconia Tab8 w1-8
> Acer One 10
> Asus T100CHI
> Asus T100HA
> Asus T100TA
> Asus T200TA
> Lenovo Mixx 2 8
> Lenovo Yoga2 tablet 10

Thanks! Wasn't aware of this, will try in the evening.

Regards,
v.

> Regards,
> 
> Hans
> 
> 
> 
> > > > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
> > > > index 7535cb0d4ac0..84571e09b465 100644
> > > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
> > > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
> > > > @@ -23,6 +23,14 @@
> > > >    /* The DMI data never changes so we can use a static buf for this */
> > > >    static char dmi_board_type[128];
> > > > +/* Array of 128 bits representing 7-bit characters allowed in DMI strings. */
> > > > +static unsigned char brcmf_dmi_allowed_chars[] = {
> > > > +	0x00, 0x00, 0x00, 0x00, 0xfe, 0x7f, 0xff, 0xff,
> > > > +	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f
> > > > +};
> > > > +
> > > > +#define BRCMF_DMI_SAFE_CHAR '_'
> > > > +
> > > >    struct brcmf_dmi_data {
> > > >    	u32 chip;
> > > >    	u32 chiprev;
> > > > @@ -99,6 +107,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
> > > >    	{}
> > > >    };
> > > > +void brcmf_dmi_sanitize(char *dst, const unsigned char *allowed, char safe)
> > > > +{
> > > > +	while (*dst) {
> > > > +		if ((*dst < 0) || !(allowed[*dst / 8] & (1 << (*dst % 8))))
> > > 
> > > At a first look I have no clue what this code is doing and I honestly do not feel
> > > like figuring it out, this is clever, but IMHO not readable.
> > 
> > Understood. The cluless part actually checks corresponding bit
> > in allowed array, which is a bit mask describing what characters
> > are allowed or not.
> > 
> > > Please just write this as if (*dst < 0x21 || (*dst > foo && < bar) || etc,
> > > so that a human can actually see in one look what the code is doing.
> > > 
> > > You may want to wait for Arend to give his opinion before changing this though,
> > > maybe he likes the code as is.
> > > 
> > > Also note that that should be < 0x20 of course, since we need to preserve spaces
> > > as is to avoid a regression.
> > 
> > This has been already discussed, spaces are a problem. There even was an
> > opinion that adding the code that doesn't bother with spaces and slashes
> > might be a regression as well.
> > 
> > Regards,
> > 
> > v.
> > 
> > > Regards,
> > > 
> > > Hans
> > > 
> > > 
> > > 
> > > 
> > > 
> > > > +			*dst = safe;
> > > > +		dst++;
> > > > +	}
> > > > +}
> > > > +
> > > >    void brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev)
> > > >    {
> > > >    	const struct dmi_system_id *match;
> > > > @@ -126,6 +143,9 @@ void brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev)
> > > >    	if (sys_vendor && product_name) {
> > > >    		snprintf(dmi_board_type, sizeof(dmi_board_type), "%s-%s",
> > > >    			 sys_vendor, product_name);
> > > > +		brcmf_dmi_sanitize(dmi_board_type,
> > > > +				   brcmf_dmi_allowed_chars,
> > > > +				   BRCMF_DMI_SAFE_CHAR);
> > > >    		settings->board_type = dmi_board_type;
> > > >    	}
> > > >    }
> > > > 
> > > 
> 
