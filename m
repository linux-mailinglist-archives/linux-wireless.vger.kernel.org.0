Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC40540078
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiFGNwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 09:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243835AbiFGNwc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 09:52:32 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415B613CC8
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 06:52:28 -0700 (PDT)
Date:   Tue, 07 Jun 2022 13:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1654609946; x=1654869146;
        bh=bD/ga/l3Lr+n8DYGtkKpGJBvbJEBjYdwhy1lQPdVevg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=X2zuqxo+OQVCsIzLDiPjCm9/l5QJo8sWU/Ju9P7vu95ovFwNElF6JXD8YUcNBhmsC
         AaY8CEHWvTsIeYW22TC9pm7fuaL5Oaie8REsTUHdRKl50yQtfoHlYX6ybu0pf57lpN
         ViX3UqA8ksaA5vh9ewM4COn2bpegvt8QZtT2wVnehT0Y5v/yzNP0aqGvG3kmFCTVWC
         ED/3P4yZA+lkWC/05W/gfqwVuv1DDEDKUACeYvUBNMdq7AxRsTXwxilRzonw6koW1m
         ojrMjBfk8KP1k2ikhklAVEHWSWa427Q4KWInbv4BVHh0oZdnCL3Dzx88iBbkvWSzTM
         I9hnqmgFRuK5g==
To:     Franky Lin <franky.lin@broadcom.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to firmware-crash
Message-ID: <EbyrCYK_mR6ppJYbSc5JfGGG_QZEZb2Zp8Htx9f-orZ_wX0Dpz1pXhDjQ9P1nGuyTH041zvsScaRIPllClzLpLgwVuff4ZTTAiVOXe5-Mwg=@dannyvanheumen.nl>
In-Reply-To: <B08447EB-F222-49B5-A411-0DB6848A80ED@broadcom.com>
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl> <Uba0mwWYafMZd4JdEJVxMd-Uh8M6T4dHoTse71YdCikdJLYLxunwtrxxbasffgMuXtPVi_JmJrtAnqviM6x-99_SyysHZm-Yvz933mPXr74=@dannyvanheumen.nl> <Y_XMhLmW7kj2Ls3X8pCfFd2RdWzXd9UWdv3ksFrVi7xh79wY7l6K52N3ODhI3_UK_IqG1uJcIEv0PxT-wQG9tdYu9krraq7gxsprUu-RtjQ=@dannyvanheumen.nl> <51CC1C7B-400C-4A7A-A5D3-EB457DC6862F@broadcom.com> <jJuvC2YezD_e1G6VFXwJjFFUAir0HFcDnBaZGRvKtnaY69v8aI3KkCouzzyOjrb9bZOnSzinETjNNxHvlmYCwNijdmts_5bEXZSV7dMNi0s=@dannyvanheumen.nl> <B08447EB-F222-49B5-A411-0DB6848A80ED@broadcom.com>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_u1VwuNeUFhngJK3oVGH30KjNimJIGtOGdbMC3IXeo"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.

--b1_u1VwuNeUFhngJK3oVGH30KjNimJIGtOGdbMC3IXeo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Franky,

------- Original Message -------
On Tuesday, June 7th, 2022 at 01:50, Franky Lin <franky.lin@broadcom.com> w=
rote:
>
>
> Hi Danny,
>
> My apology. I didn=E2=80=99t read the thread carefully and failed to noti=
ce the rev1 to rev 2 change of the patch.
>
> > On Jun 4, 2022, at 7:59 AM, Danny van Heumen danny@dannyvanheumen.nl wr=
ote:
> >
> > Hi Franky,
> >
> > ------- Original Message -------
> > On Saturday, June 4th, 2022 at 00:58, Franky Lin franky.lin@broadcom.co=
m wrote:
> >
> > > Hi Danny,
> > >
> > > [..]
> > >
> > > Thanks for reporting and sending out a patch to fix this.
> > >
> > > If the problem is double freeing the freezer buffer, it should be add=
ressed from the root by setting pointer to NULL. Same thing might need to b=
e done for sg table as well. Sorry I don=E2=80=99t have any sdio module to =
reproduce and test. Please see if the below change fixes the problem.
> >
> > Your suggestion to set the freeze buffer address to zero was also my fi=
rst proposal. I have since
> > revised, because there are a few things I considered, although I am not=
 sure:
> >
> > - does zero-ing the address prevent future detection of double-frees wi=
th the hardened memory
> > allocator? (If so, I would prefer to avoid doing this.)
> > - IIUC correctly, 'sdio_set_block_size' does not do any meaningful "act=
ivation" or "allocation".
> > Therefore would not need to be undone. (repeated probes would override =
previous calls)
> > - Starting with the call 'sdio_enable_func', I guess/suspect more elabo=
rate "cleanup" is necessary
> > therefore, leaving the 'goto out' from that point on. I would assume (f=
or lack of evidence to the
> > contrary) that the logic at 'goto out' provides proper clean-up.
>
>
> While directly return without invoking clean up process makes perfect sen=
se for the issue described here, it doesn=E2=80=99t address the broader iss=
ue that sdiodev might hold on to couple stale pointers that might subsequen=
tly be used in somewhere down the path because sdiodev is not freed. Settin=
g these pointer to NULL after freeing them could help us to catch such issu=
e which is more catastrophic than a double-free. The perfect solution of co=
urse is to rework the code to free sdiodev whenever brcmf_sdiod_remove() is=
 invoked but that can not be done in short-term unfortunately.

- True.
- If the two early returns are appropriate -- I think they are -- so we can=
 leave those in. (Again, I'm unfamiliar with the code-base.)
- Setting the pointer to NULL at least has the benefit that behavior (even =
if bugged) is the same irrespective of memory allocation behavior.
- I checked your suggestion for 'sdiodev->sgtable': it is not a pointer, so=
 setting to NULL will not help. If I read this correctly, 'sg_free_table(..=
)' is already resistant to multiple freeing attempts with a test of '.sgl'.

.. as for the control flow. Sure, rework would be nice, but -- to me at lea=
st -- it is not clear if it is really necessary. Maybe I'm mistaken, but th=
ere seem to be few entry-points to take into account. The "hardware-reset a=
fter firmware-crash"-logic was added later IIUC, so maybe it was an oversig=
ht? Regardless, I have updated the patch.

>
> Also I forgot that our IT attached a legal footer to all emails sent to a=
n external party. I am sorry about that to anyone reading my mail but there=
 is nothing I can do at the moment.
>
> Thanks,
> - Franky

I have attached the updated patch. As mentioned before, I will be running t=
he changes myself.

Regards,
Danny



> > So, returning immediately with the errorcode seemed more appropriate. R=
egardless, I have only
> > incidental knowledge from checking the code just for this particular pr=
oblem. In the end my goal
> > is to have the issues addressed so that I am not forced to reboot my sy=
stem to get it back in
> > working order.
> >
> > As for your remark about sg-table: I had not considered that, but if my=
 notes above check out,
> > maybe this does not need to be treated conditionally at all.
> >
> > Kind regards,
> > Danny
> >
> > > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.=
c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > > index ac02244a6fdf..e9bad7197ba9 100644
> > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> > > @@ -802,6 +802,7 @@ static void brcmf_sdiod_freezer_detach(struct brc=
mf_sdio_dev *sdiodev)
> > > if (sdiodev->freezer) {
> > >
> > > WARN_ON(atomic_read(&sdiodev->freezer->freezing));
> > >
> > > kfree(sdiodev->freezer);
> > >
> > > + sdiodev->freezer =3D NULL;
> > >
> > > }
> > > }
> > >
> > > @@ -885,7 +886,11 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev *sd=
iodev)
> > > sdio_disable_func(sdiodev->func1);
> > >
> > > sdio_release_host(sdiodev->func1);
> > >
> > > - sg_free_table(&sdiodev->sgtable);
> > >
> > > + if (sdiodev->sgtable) {
> > >
> > > + sg_free_table(&sdiodev->sgtable);
> > >
> > > + sdiodev->sgtable =3D NULL;
> > >
> > > + }
> > > +
> > > sdiodev->sbwad =3D 0;
> > >
> > > pm_runtime_allow(sdiodev->func1->card->host->parent);
> > >
> > > As for submitting patch to linux-wireless, please follow the guidelin=
e. [1]
> > >
> > > Thanks,
> > > - Franky
> > >
> > > [1] https://www.google.com/url?q=3Dhttps://wireless.wiki.kernel.org/e=
n/developers/documentation/submittingpatches&source=3Dgmail-imap&ust=3D1654=
959604000000&usg=3DAOvVaw1Q6aXVZjiKkrq9qmyYVVDa
>
>
>
>
>
> --
> This electronic communication and the information and any files transmitt=
ed
> with it, or attached to it, are confidential and are intended solely for
> the use of the individual or entity to whom it is addressed and may conta=
in
> information that is confidential, legally privileged, protected by privac=
y
> laws, or otherwise restricted from disclosure to anyone else. If you are
> not the intended recipient or the person responsible for delivering the
> e-mail to the intended recipient, you are hereby notified that any use,
> copying, distributing, dissemination, forwarding, printing, or copying of
> this e-mail is strictly prohibited. If you received this e-mail in error,
> please return the e-mail to the sender, delete it from your computer, and
> destroy any printed copy of it.
--b1_u1VwuNeUFhngJK3oVGH30KjNimJIGtOGdbMC3IXeo
Content-Type: text/x-patch; name=0001-brcmfmac-prevent-double-free-on-hardware-reset.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-brcmfmac-prevent-double-free-on-hardware-reset.patch

RnJvbSBhZDQ3MWZhNjY0ZGFiODY1NzM2MTgzZTY2OWYyMmNjYWZmNmY1MTk3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5ueSB2YW4gSGV1bWVuIDxkYW5ueUBkYW5ueXZhbmhldW1l
bi5ubD4KRGF0ZTogVHVlLCAyNCBNYXkgMjAyMiAxODozMDo1MCArMDIwMApTdWJqZWN0OiBbUEFU
Q0hdIGJyY21mbWFjOiBwcmV2ZW50IGRvdWJsZS1mcmVlIG9uIGhhcmR3YXJlLXJlc2V0LgoKSW4g
Y2FzZSBvZiBidWdneSBmaXJtd2FyZSwgYnJjbWZtYWMgbWF5IHBlcmZvcm0gYSBoYXJkd2FyZSBy
ZXNldC4gSWYgZHVyaW5nCnJlc2V0IGFuZCBzdWJzZXF1ZW50IHByb2JpbmcgYW4gZWFybHkgZmFp
bHVyZSBvY2N1cnMsIGEgbWVtb3J5IHJlZ2lvbiBpcwphY2NpZGVudGFsbHkgZG91YmxlLWZyZWVk
LiBXaXRoIGhhcmRlbmVkIG1lbW9yeSBhbGxvY2F0aW9uIGVuYWJsZWQsIHRoaXMgZXJyb3IKd2ls
bCBiZSBkZXRlY3RlZC4KCi0gcmV0dXJuIGVhcmx5IHdoZXJlIGFwcHJvcHJpYXRlIHRvIHNraXAg
dW5uZWNlc3NhcnkgY2xlYW4tdXAuCi0gc2V0ICcuZnJlZXplcicgcG9pbnRlciB0byBOVUxMIHRv
IHByZXZlbnQgZG91YmxlLWZyZWVpbmcgdW5kZXIgcG9zc2libGUKICBvdGhlciBjaXJjdW1zdGFu
Y2VzIGFuZCB0byByZS1hbGlnbiByZXN1bHQgdW5kZXIgdmFyaW91cyBkaWZmZXJlbnQKICBiZWhh
dmlvcnMgb2YgbWVtb3J5IGFsbG9jYXRpb24gZnJlZWluZy4KCkdpdmVuIGEgZmlybXdhcmUgY3Jh
c2gsIGZ1bmN0aW9uICdicmNtZl9zZGlvX2J1c19yZXNldCcgaXMgY2FsbGVkLiBJdCBjYWxscwon
YnJjbWZfc2Rpb2RfcmVtb3ZlJywgdGhlbiBmb2xsb3dzIHVwIHdpdGggJ2JyY21mX3NkaW9kX3By
b2JlJyB0byByZWluaXRpYWxpemUKdGhlIGhhcmR3YXJlLiBJZiAnYnJjbWZfc2Rpb2RfcHJvYmUn
IGZhaWxzIHRvICJzZXQgRjEgYmxvY2tzaXplIiwgaXQgZXhpdHMKZWFybHksIHdoaWNoIGluY2x1
ZGVzIGNhbGxpbmcgJ2JyY21mX3NkaW9kX3JlbW92ZScuIEluIGJvdGggY2FzZXMKJ2JyY21mX3Nk
aW9kX2ZyZWV6ZXJfZGV0YWNoJyBpcyBjYWxsZWQgdG8gZnJlZSBhbGxvY2F0ZWQgJy5mcmVlemVy
Jywgd2hpY2gKaGFzIG5vdCB5ZXQgYmVlbiByZS1hbGxvY2F0ZWQgdGhlIHNlY29uZCB0aW1lLgoK
U3RhY2t0cmFjZSBvZiAoZmFpbGluZykgaGFyZHdhcmUgcmVzZXQgYWZ0ZXIgZmlybXdhcmUtY3Jh
c2g6CgpDb2RlOiBiOTQwMmI4MiA4YjAyMDJjMCBlYjFhMDJkZiA1NDAwMDA0MSAoZDQyMTAwMDAp
CiByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMAoga3RocmVhZCsweDE1NC8weDE2MAogd29ya2VyX3Ro
cmVhZCsweDE4OC8weDUwNAogcHJvY2Vzc19vbmVfd29yaysweDFmNC8weDQ5MAogYnJjbWZfY29y
ZV9idXNfcmVzZXQrMHgzNC8weDQ0IFticmNtZm1hY10KIGJyY21mX3NkaW9fYnVzX3Jlc2V0KzB4
NjgvMHhjMCBbYnJjbWZtYWNdCiBicmNtZl9zZGlvZF9wcm9iZSsweDE3MC8weDIxYyBbYnJjbWZt
YWNdCiBicmNtZl9zZGlvZF9yZW1vdmUrMHg0OC8weGMwIFticmNtZm1hY10KIGtmcmVlKzB4MjEw
LzB4MjIwCiBfX3NsYWJfZnJlZSsweDU4LzB4NDBjCkNhbGwgdHJhY2U6CngyIDogMDAwMDAwMDAw
MDAwMDA0MCB4MSA6IGZmZmZmYzAwMDAyZDJiODAgeDAgOiBmZmZmMDAwMDBiNGFlZTQwCng1IDog
ZmZmZjgwMDAwMTNmYTcyOCB4NCA6IDAwMDAwMDAwMDAwMDAwMDEgeDMgOiBmZmZmMDAwMDBiNGFl
ZTAwCng4IDogZmZmZjgwMDAwOTk2N2NlMCB4NyA6IGZmZmY4MDAwMDk5YmZjZTAgeDYgOiAwMDAw
MDAwNmY4MDA1ZDAxCngxMTogZmZmZjgwMDAwOTliZmNlMCB4MTA6IDAwMDAwMDAwZmZmZmYwMDAg
eDkgOiBmZmZmODAwMDA4MzQwMWQwCngxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6IDY1N2E2OTcz
NmI2MzZmNmMgeDEyOiA2MjIwMzE0NjIwNzQ2NTczCngxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6
IDAwMDAwMDAwMDAwMDAwMDAgeDE1OiAwMDAwMDAwMDAwMDAwMDMwCngyMDogZmZmZmZjMDAwMDJk
MmJhMCB4MTk6IGZmZmZmYzAwMDAyZDJiODAgeDE4OiAwMDAwMDAwMDAwMDAwMDAwCngyMzogZmZm
ZjAwMDAwYjRhZWUwMCB4MjI6IGZmZmYwMDAwMGI0YWVlMDAgeDIxOiAwMDAwMDAwMDAwMDAwMDAx
CngyNjogZmZmZjAwMDAwYjRhZWUwMCB4MjU6IGZmZmYwMDAwZjc3NTM3MDUgeDI0OiAwMDAwMDAw
MDAwMDEyODhhCngyOTogZmZmZjgwMDAwYTIyYmJmMCB4Mjg6IGZmZmYwMDAwMDA0MDEyMDAgeDI3
OiAwMDAwMDAwMDgwMjAwMDFhCnNwIDogZmZmZjgwMDAwYTIyYmJmMApsciA6IGtmcmVlKzB4MjEw
LzB4MjIwCnBjIDogX19zbGFiX2ZyZWUrMHg1OC8weDQwYwpwc3RhdGU6IDYwMDAwMDA1IChuWkN2
IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBCVFlQRT0tLSkKV29ya3F1ZXVlOiBldmVu
dHMgYnJjbWZfY29yZV9idXNfcmVzZXQgW2JyY21mbWFjXQpIYXJkd2FyZSBuYW1lOiBQaW5lNjQg
UGluZWJvb2sgUHJvIChEVCkKQ1BVOiAyIFBJRDogNjM5IENvbW06IGt3b3JrZXIvMjoyIFRhaW50
ZWQ6IEcgICAgICAgICBDICAgICAgICA1LjE2LjAtMC5icG8uNC1hcm02NCAjMSAgRGViaWFuIDUu
MTYuMTItMX5icG8xMSsxCiBudm1lbV9yb2NrY2hpcF9lZnVzZSBpbmR1c3RyaWFsaW9fdHJpZ2dl
cmVkX2J1ZmZlciB2aWRlb2RldiBzbmRfc29jX2NvcmUgc25kX3BjbV9kbWFlbmdpbmUga2ZpZm9f
YnVmIHNuZF9wY20gaW9fZG9tYWluIG1jIGluZHVzdHJpYWxpbyBtdD4KTW9kdWxlcyBsaW5rZWQg
aW46IHNuZF9zZXFfZHVtbXkgc25kX2hydGltZXIgc25kX3NlcSBzbmRfc2VxX2RldmljZSBuZnRf
ZmliX2luZXQgbmZ0X2ZpYl9pcHY0IG5mdF9maWJfaXB2NiBuZnRfZmliIG5mdF9yZWplY3RfaW5l
dCBuZl9yZWplPgpJbnRlcm5hbCBlcnJvcjogT29wcyAtIEJVRzogMCBbIzFdIFNNUAprZXJuZWwg
QlVHIGF0IG1tL3NsdWIuYzozNzkhCgpTaWduZWQtb2ZmLWJ5OiBEYW5ueSB2YW4gSGV1bWVuIDxk
YW5ueUBkYW5ueXZhbmhldW1lbi5ubD4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNv
bS9icmNtODAyMTEvYnJjbWZtYWMvYmNtc2RoLmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9iY21zZGguYyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9iY21zZGguYwppbmRleCBh
YzAyMjQ0YTZmZGYuLjVjNmI4NDYyODRkZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2JjbXNkaC5jCisrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9iY21zZGguYwpAQCAtODAyLDYg
KzgwMiw3IEBAIHN0YXRpYyB2b2lkIGJyY21mX3NkaW9kX2ZyZWV6ZXJfZGV0YWNoKHN0cnVjdCBi
cmNtZl9zZGlvX2RldiAqc2Rpb2RldikKIAlpZiAoc2Rpb2Rldi0+ZnJlZXplcikgewogCQlXQVJO
X09OKGF0b21pY19yZWFkKCZzZGlvZGV2LT5mcmVlemVyLT5mcmVlemluZykpOwogCQlrZnJlZShz
ZGlvZGV2LT5mcmVlemVyKTsKKwkJc2Rpb2Rldi0+ZnJlZXplciA9IE5VTEw7CiAJfQogfQogCkBA
IC05MTEsNyArOTEyLDcgQEAgaW50IGJyY21mX3NkaW9kX3Byb2JlKHN0cnVjdCBicmNtZl9zZGlv
X2RldiAqc2Rpb2RldikKIAlpZiAocmV0KSB7CiAJCWJyY21mX2VycigiRmFpbGVkIHRvIHNldCBG
MSBibG9ja3NpemVcbiIpOwogCQlzZGlvX3JlbGVhc2VfaG9zdChzZGlvZGV2LT5mdW5jMSk7Ci0J
CWdvdG8gb3V0OworCQlyZXR1cm4gcmV0OwogCX0KIAlzd2l0Y2ggKHNkaW9kZXYtPmZ1bmMyLT5k
ZXZpY2UpIHsKIAljYXNlIFNESU9fREVWSUNFX0lEX0JST0FEQ09NX0NZUFJFU1NfNDM3MzoKQEAg
LTkzMyw3ICs5MzQsNyBAQCBpbnQgYnJjbWZfc2Rpb2RfcHJvYmUoc3RydWN0IGJyY21mX3NkaW9f
ZGV2ICpzZGlvZGV2KQogCWlmIChyZXQpIHsKIAkJYnJjbWZfZXJyKCJGYWlsZWQgdG8gc2V0IEYy
IGJsb2Nrc2l6ZVxuIik7CiAJCXNkaW9fcmVsZWFzZV9ob3N0KHNkaW9kZXYtPmZ1bmMxKTsKLQkJ
Z290byBvdXQ7CisJCXJldHVybiByZXQ7CiAJfSBlbHNlIHsKIAkJYnJjbWZfZGJnKFNESU8sICJz
ZXQgRjIgYmxvY2tzaXplIHRvICVkXG4iLCBmMl9ibGtzeik7CiAJfQotLSAKMi4zNC4xCgo=

--b1_u1VwuNeUFhngJK3oVGH30KjNimJIGtOGdbMC3IXeo--

