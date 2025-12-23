Return-Path: <linux-wireless+bounces-30079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC7ACD8411
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 07:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 500A13002178
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111A72F1FF4;
	Tue, 23 Dec 2025 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qejrEPDa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2D1A275;
	Tue, 23 Dec 2025 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471475; cv=none; b=eE2Xo2xhyn+4NbHKy+Pyhox8T7bqFJqobA94wkCtL1zHh2iu3al+wsqu3u3Q0GVx0l47rD/HeOdVAG6G1EgTdW80/JSg6jxI4MeV1Ivcsy/BTg0JWOoWGY7LR3FihvWRe0UIr1fYAFZRtLX2CUQ1Man9hN0MVAHAWtfMsFQgaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471475; c=relaxed/simple;
	bh=RiDJuepokjtCc/A1gz3oaco/FAC3gt7ctaKz2LrTrKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0ct70IJ5Y2nXnBMY7rmviCbLU1xplAvMjPVSb9wAX2A5N6qiIu0tSLVYGc5hUm9xxY1S97rqsd1G2lRObKIIhbGQOxezyNzRRiVQICIb+w3XFMrwlIv/ul701eSpoQC7D8N5trWMZ5JnU6AnoMNGuOaRZ4QCiPa3mxW8fX7cYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qejrEPDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B30C116B1;
	Tue, 23 Dec 2025 06:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766471475;
	bh=RiDJuepokjtCc/A1gz3oaco/FAC3gt7ctaKz2LrTrKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qejrEPDakY+OTg7V3I4z7DZaU00Dvvx/S4tIto9ctI1+Z/+flU+mCxJDoMHTSHcqg
	 oAZefPZ1zx4na2QUpDRsnatlQmhZLqk5ew0i0x83h6l5o3AVj1nPjPC1n/TWT/GpET
	 zQ7NoVjKwt6KKwAbrymbYpzhpWdktANUbeVJuZMuYN0eESDBf0UVc4wkoY0T30ZU3O
	 J6LcTSEIShDaG6gxLaFTn8Ie+m4ilFsIbmHWDzMRvrmC7KXP0NB7M8oI6bY1kmYkLf
	 ADoz3LqBDuT2a652kSwowPyPR/o1MNji7tVt/N8uH+yXBlmYJGmU+fveudwhmMrg/M
	 swzZ3YkpeKKLQ==
Date: Tue, 23 Dec 2025 12:01:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: Bryan O'Donoghue <bod.linux@nxsw.ie>, jerome.debretagne@gmail.com, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Dale Whinham <daleyo@gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
Message-ID: <2ixwny6hzumlqmok5cjwutvtk7nzmx4t3dhxc44ao4l2u755pj@n6m7jyxf2o62>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
 <M7kfFb5fz-WB43U_xCUwgxpmBJ4TNdp4jE6yFu6HmemIcDx5tXO6H4xnW_pEQz6DMkKm-3POdB9hIdB092zhGQ==@protonmail.internalid>
 <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
 <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie>
 <c29de60c-c7c6-45d7-8d90-616df23df01c@kernel.org>
 <v4hxei4t7n6ebvw6heoccei2t3mskq7uo7zejv6dyvvq5fr5sv@xzpsiic5x7a4>
 <2ff993a7-0fda-4337-9acc-92aaa75be750@kernel.org>
 <blbyjjkcxwnm5otgkodckxl2gx5ncelhnpqire7jt3yfdvszef@jgk6o7yvn2vo>
 <8b79b662-931f-4634-9389-6602d353d67a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b79b662-931f-4634-9389-6602d353d67a@kernel.org>

On Mon, Dec 22, 2025 at 03:22:55PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 22-Dec-25 14:41, Manivannan Sadhasivam wrote:
> > On Mon, Dec 22, 2025 at 01:41:48PM +0100, Hans de Goede wrote:
> >> Hi Mani,
> >>
> >> On 22-Dec-25 12:45, Manivannan Sadhasivam wrote:
> >>> On Mon, Dec 22, 2025 at 11:23:18AM +0100, Hans de Goede wrote:
> >>>> +Cc Mani
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 20-Dec-25 07:04, Bryan O'Donoghue wrote:
> >>>>> On 20/12/2025 00:21, Jérôme de Bretagne via B4 Relay wrote:
> >>>>>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> >>>>>>
> >>>>>> For some devices, Wi-Fi is entirely hard blocked by default making
> >>>>>> the Wi-Fi radio unusable, except if rfkill is disabled as expected
> >>>>>> on those models.
> >>>>>>
> >>>>>> Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
> >>>>>> disabling specific features based on ACPI bitflag") added a way to
> >>>>>> support features set via ACPI, including the DISABLE_RFKILL bit.
> >>>>>>
> >>>>>> Add a disable-rfkill property to expose the DISABLE_RFKILL bit
> >>>>>> equivalent for devices described by a Devicetree instead of ACPI.
> >>>>>>
> >>>>>> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> >>>>>> ---
> >>>>>>   Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 ++++++
> >>>>>>   1 file changed, 6 insertions(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> >>>>>> index d89f7a3f88a71d45d6f4ab2ae909eae09cbcaf9a..c10a4675640be947cd0b5eaec2c7ff367fd93945 100644
> >>>>>> --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> >>>>>> @@ -29,6 +29,12 @@ properties:
> >>>>>>         different 5 GHz subbands. Using them incorrectly could not work or
> >>>>>>         decrease performance noticeably
> >>>>>>
> >>>>>> +  disable-rfkill:
> >>>>>> +    type: boolean
> >>>>>> +    description:
> >>>>>> +      Disable rfkill for some devices on which Wi-Fi would be entirely hard
> >>>>>> +      blocked by default otherwise
> >>>>>> +
> >>>>>>   additionalProperties: true
> >>>>>>
> >>>>>>   examples:
> >>>>>>
> >>>>>> -- 
> >>>>>> 2.47.3
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> Is this really a hardware description though ?
> >>>>
> >>>> I would say yes it is. The wifi chip has an rfkill input pin and
> >>>> things will be broken when that pin is hardwired to a fixed value
> >>>> rather then being actually connected to a GPIO from say
> >>>> the embedded controller.
> >>>>
> >>>
> >>> IIUC, even if the M.2 slot has the W_DISABLE1# signal routed from the host,
> >>> the device won't make use of it as there is no physical connection. So you want
> >>> the WLAN driver to change the state through SW?
> >>>
> >>>> So I think that we would need here is not a disable-rfkill property
> >>>> but some way to indicate in the DT-node that the rfkill input pin
> >>>> is not connected and thus should be ignored.
> >>>>
> >>>> This (the rfkill input pin being not-connected) IMHO very much
> >>>> is hw-description.
> >>>>
> >>>
> >>> Though we can argue this way, I would prefer to handle it in the driver. For
> >>> example, with my M.2 series, we will end up describing the M.2 slot:
> >>>
> >>> 	connector {
> >>> 		compatible = "pcie-m2-e-connector";
> >>> 		w-disable1-gpios = <&tlmm 117 GPIO_ACTIVE_LOW>;
> >>> 		...
> >>> 		ports {
> >>> 			...
> >>> 			endpoint@0 {
> >>> 				reg = <0>;
> >>> 				remote-endpoint = <&pcie4_port0_ep>;
> >>> 			};
> >>> 		};
> >>> 	};
> >>>
> >>> Then if we use a DT property to convey the RFKILL pin state of the device, we
> >>> would need to describe the endpoint device in DT and hardcode the state:
> >>>
> >>> 	&pcie4_port0 {
> >>> 		...
> >>> 		port {
> >>> 			pcie4_port0_ep: endpoint {
> >>> 				remote-endpoint = <&m2_e_pcie_ep>;
> >>> 				disable-rfkill;
> >>> 			};
> >>> 		};
> >>> 	};
> >>>
> >>> So this will essentially make the M.2 device non-swappable unless you change the
> >>> DT since you've how hardcoded the device property in the binding. This is
> >>> something I try to avoid to make the M.2 slot really swappable.
> >>>
> >>> For this reason, I would prefer to handle the RFKILL state in the WLAN driver
> >>> using the device specific compatible. This will be problematic only if multiple
> >>> cards of the same Device ID have different RFKILL state and the devices are not
> >>> distinguishable even with sub IDs.
> >>
> >> I think we're miscommunicating here. I'm not talking about the card having
> >> a broken rfkill implementation, I'm talking about the M.2 slot on the mainboard
> >> having e.g. W_DISABLE1# hardwired in such a way that cards would interpret it as
> >> having to always disable their wifi radio which is very similar to what is
> >> happening on the surface device. Except that on the Surface there is no M.2 slot,
> >> the wifi is just soldered onto the mainboard I believe.
> >>
> > 
> > Ah, sorry for the confusion. I did misinterpret what you said.
> > 
> >> Based on experience I'm pretty sure we will encounter M.2 slots which such
> >> a hardwired W_DISABLE1# signal sooner rather then later.
> >>
> > 
> > But it makes no sense IMO. Vendors will usually connect unimplemented W_DISABL1#
> > GPIOs to a pull-up resistor so that the radios are operational all the time. I
> > don't see how they would expect a WLAN or any device with a radio to be
> > connected to the slot if they hardwire the pin to low.
> 
> Pins which are considered "unused" are also often hardwired
> to ground. If the m.2 slot is tested with a wifi-module where
> the W_DISABLE1# signal is not used on the wifi-module I can
> easily see this happen. I've seen a lot crazier / buggy stuff
> happen.
> 
> > Are you sure that on the surface the pin is actually hardwired to low and not
> > connected to a GPIO that drivers the signal low?
> 
> I don't know what is the exact problem on the Surface. I just
> expect to see this more often, we've certainly seen lots of
> issues like this on x86 laptops. Things end up looking like
> the hard rfkill is activated all the time (and we often don't know
> if this is a fw issue, or an actually hardwired problem).
> 
> Just an example from the top of my head the Broadcom windows
> drivers use different BT fw files for the same wifi/bt combo
> chip depending on the vend:prod id pair. One of the things which
> is different is that some fw files invert the BT rfkill signal
> because it is wired wrong (or there is an EC fw bug) and this
> is then worked around in the bt fw.
> 
> As we see a growing proliferation of arm64 laptops I fully
> expect all the fun from having a gazillion different designs
> with a time to market rush behind them result in similar issues
> on arm64.
> 
> Note I'm not saying we must tackle this today, we can wait
> till we see the first case in the real world I guess.
> 
> I just thought that based on my experience this is more or
> less bound to happen, we could comeup with a solution for
> this now and then this solution could also nicely serve
> the Surface case which started this thread.
> 
> But we can also delay tackling this and come up with some
> bespoke solution for the Surface case, like as suggested
> maybe a special compatible string ?
> 

Hmm. If we want to go with the DT property, I'd use something like
'broken-rfkill' or 'broken-w-disable1' or similar in the connector node, not in
the device node. This will convey the fact that the RFKILL switch is broken
in the connector or the hardware topology is not known.

But we do not have the connector binding merged yet. Until then, I'd suggest to
keep the hack in the WLAN driver by using the platform compatible and Device ID:

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index cc352eef1939..481778eb2c95 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -77,6 +77,16 @@ static int ath12k_core_rfkill_config(struct ath12k_base *ab)
        if (ath12k_acpi_get_disable_rfkill(ab))
                return 0;
 
+       /*
+        * TODO: On Microsoft Surface Pro 11, OS is not able to control the
+        * RFKILL switch. So keep the RFKILL disabled until the OS learns about
+        * it. Ideally, this info should come from the connector node of the
+        * board DT file. But since the connector DT node is not available,
+        * implement the hack in the driver.
+        */
+       if (of_machine_is_compatible("microsoft,denali") && (ab->id.device == 0x1107))
+               return 0;
+
        for (i = 0; i < ab->num_radios; i++) {
                ar = ab->pdevs[i].ar;


Once the connector binding gets merged, hopefully we can add the DT property and
use it in the driver.

> > It is just hard to believe that board designers can do a blunder like this.
> 
> Heh, you won't believe all the crap happening on cheap
> x86 devices.
> 

Coming from the DT world, I thought the ACPI world is superior, but this reminds
of the fact "No world is superior to another" :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

