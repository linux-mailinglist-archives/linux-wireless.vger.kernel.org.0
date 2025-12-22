Return-Path: <linux-wireless+bounces-30049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D160FCD5D69
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 12:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E0A43019BF9
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB079313E2D;
	Mon, 22 Dec 2025 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6GBvEeK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3521FF23;
	Mon, 22 Dec 2025 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766403923; cv=none; b=lYo51k/PyzqC7N/D1VnC4d345gJNlL7RQpDbuvVWO6IArY+twPXZDp3DfJCpVByqXOEjRGOOWgXFMbeKhqjBogDzQK09kAnTAA1hT3H7eyLYjUb/tLCpRquKZ0Ql+GBSw/bPW2dCaqZFfJEgOPcd+G6qxT/lDXSUMi/fHtgdgCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766403923; c=relaxed/simple;
	bh=a3HAZXboIYJtAUAVesMtixmEpYZ6agiytIhdOW9P2HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOy31/fDZxZjseG57AFfmu5E1WV8SgpR6TMONn6+/PCzaCn0HGtehLBRJ63llVkWaV2FvoHPV9S2MNVotvyjlET54wfzUnyWwMukv884DBo+N8k0sRUpPsLOaZLqFDyYsWfgKU9wlkiV/czUhK0Lq2mQ31vFMYAB12KerDavYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6GBvEeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA7DC4CEF1;
	Mon, 22 Dec 2025 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766403923;
	bh=a3HAZXboIYJtAUAVesMtixmEpYZ6agiytIhdOW9P2HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6GBvEeK7QJIwyVC0RguQ8ppbhf51QHCw6gAC9fbdnqgVssO3G4JNHD4Dag9JsdU8
	 gH/BPSeZZ2RbMHrvJSd3yGXap6TfLSEA78UkcgthxVw9F9jgOl3jghxJh3OQw40Ilj
	 RYkBP5lOkDJvbkcgJVyAWND1g2rHAARICk89OBfJ9SCd2to93kVQjsA4D9JG92aqOY
	 2gGgc47Xi5xvRX6rnaHUTjP9/soKRV70zOW4zdd0n4ncZtFIY5+FfjtM+eJc7V1RsN
	 0hajoj0KmFqLiZZR5bjuug2o7TycznWf+owlgZLVJEiTsjkPzwm3vMzz9jTFcbMZlS
	 c5iC2jQalglEA==
Date: Mon, 22 Dec 2025 17:15:05 +0530
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
Message-ID: <v4hxei4t7n6ebvw6heoccei2t3mskq7uo7zejv6dyvvq5fr5sv@xzpsiic5x7a4>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
 <M7kfFb5fz-WB43U_xCUwgxpmBJ4TNdp4jE6yFu6HmemIcDx5tXO6H4xnW_pEQz6DMkKm-3POdB9hIdB092zhGQ==@protonmail.internalid>
 <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
 <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie>
 <c29de60c-c7c6-45d7-8d90-616df23df01c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c29de60c-c7c6-45d7-8d90-616df23df01c@kernel.org>

On Mon, Dec 22, 2025 at 11:23:18AM +0100, Hans de Goede wrote:
> +Cc Mani
> 
> Hi,
> 
> On 20-Dec-25 07:04, Bryan O'Donoghue wrote:
> > On 20/12/2025 00:21, Jérôme de Bretagne via B4 Relay wrote:
> >> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> >>
> >> For some devices, Wi-Fi is entirely hard blocked by default making
> >> the Wi-Fi radio unusable, except if rfkill is disabled as expected
> >> on those models.
> >>
> >> Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
> >> disabling specific features based on ACPI bitflag") added a way to
> >> support features set via ACPI, including the DISABLE_RFKILL bit.
> >>
> >> Add a disable-rfkill property to expose the DISABLE_RFKILL bit
> >> equivalent for devices described by a Devicetree instead of ACPI.
> >>
> >> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> >> ---
> >>   Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> >> index d89f7a3f88a71d45d6f4ab2ae909eae09cbcaf9a..c10a4675640be947cd0b5eaec2c7ff367fd93945 100644
> >> --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> >> +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> >> @@ -29,6 +29,12 @@ properties:
> >>         different 5 GHz subbands. Using them incorrectly could not work or
> >>         decrease performance noticeably
> >>
> >> +  disable-rfkill:
> >> +    type: boolean
> >> +    description:
> >> +      Disable rfkill for some devices on which Wi-Fi would be entirely hard
> >> +      blocked by default otherwise
> >> +
> >>   additionalProperties: true
> >>
> >>   examples:
> >>
> >> -- 
> >> 2.47.3
> >>
> >>
> >>
> > 
> > Is this really a hardware description though ?
> 
> I would say yes it is. The wifi chip has an rfkill input pin and
> things will be broken when that pin is hardwired to a fixed value
> rather then being actually connected to a GPIO from say
> the embedded controller.
> 

IIUC, even if the M.2 slot has the W_DISABLE1# signal routed from the host,
the device won't make use of it as there is no physical connection. So you want
the WLAN driver to change the state through SW?

> So I think that we would need here is not a disable-rfkill property
> but some way to indicate in the DT-node that the rfkill input pin
> is not connected and thus should be ignored.
> 
> This (the rfkill input pin being not-connected) IMHO very much
> is hw-description.
> 

Though we can argue this way, I would prefer to handle it in the driver. For
example, with my M.2 series, we will end up describing the M.2 slot:

	connector {
		compatible = "pcie-m2-e-connector";
		w-disable1-gpios = <&tlmm 117 GPIO_ACTIVE_LOW>;
		...
		ports {
			...
			endpoint@0 {
				reg = <0>;
				remote-endpoint = <&pcie4_port0_ep>;
			};
		};
	};

Then if we use a DT property to convey the RFKILL pin state of the device, we
would need to describe the endpoint device in DT and hardcode the state:

	&pcie4_port0 {
		...
		port {
			pcie4_port0_ep: endpoint {
				remote-endpoint = <&m2_e_pcie_ep>;
				disable-rfkill;
			};
		};
	};

So this will essentially make the M.2 device non-swappable unless you change the
DT since you've how hardcoded the device property in the binding. This is
something I try to avoid to make the M.2 slot really swappable.

For this reason, I would prefer to handle the RFKILL state in the WLAN driver
using the device specific compatible. This will be problematic only if multiple
cards of the same Device ID have different RFKILL state and the devices are not
distinguishable even with sub IDs.

FWIW, ACPI support added with commit c6a7c0b09d5f, suffers from the same
limitation.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

