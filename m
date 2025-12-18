Return-Path: <linux-wireless+bounces-29900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25562CCC330
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 15:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 896F13015AA4
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0A33B6FF;
	Thu, 18 Dec 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TruMxveD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42933ADBB;
	Thu, 18 Dec 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067038; cv=none; b=iGfVLh8uTiuuCAKtS6Spc0JH/q5RWy/8HE1z5ywlaKlCthH9s5dLfs1SysY6qBdg+IWdey+unTm1nWxNH+pNEx1K4hgJGOXQxyQU3oMgKhEuulIc1Flrzz8Dsq4oOF3/09LcUIoUb6wP7y30RhJRoV6Le5u+/oqfQG4XJ9MTOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067038; c=relaxed/simple;
	bh=uWVUzQxgNzNm2gDea1wolnfAvDM7o/AcptcBe7EbEUI=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=QCLhhJJ2TRUNZWKosMTDl1tjADmq+z9YZjO3/RCYyDn47g0tzWm8Go9TIzaEqfzWcrsVxRRuSf0FaXD7ZjKVpAg9EdzKExha+UZzHuz2/Vtom4dxBFdZ/RUkynCSxTsAdJbVe/s/rWxoH44VRpUxxGzcEw5x7TQcTapSjE5qpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TruMxveD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4115AC4CEFB;
	Thu, 18 Dec 2025 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766067037;
	bh=uWVUzQxgNzNm2gDea1wolnfAvDM7o/AcptcBe7EbEUI=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=TruMxveDz6ybcxHnux5H+BkQmQnJCSNrtTZKrvMJoxZ/NgBz7ZIiO7GGfTi6LDp4m
	 SGHpgmWGJrbWpT1OavpDG9XMfQkG/XlmF5n7NsNQ5m0cNJy9VFtIS2dougmR0nRRRU
	 VZX/fs1cdbWy4NHffk8WjLis8WnLMP5RKLDeo+LyyVY4KdW32VZicpz8sLRFA8wBB/
	 WRKExKhK05Noe4RocbrgZlSpxCjO1LZ4bZRpxasa3YoxtgJJS9D8SSy1VQe0UpLZI6
	 vxYsxsMPj3qWN+3OBYPCpdax8OEELLB2i6jMeahsxe7m0IQOI5DvufRjZPh2y6d0No
	 amyfOhzdXNeZQ==
From: Rob Herring <robh@kernel.org>
Date: Thu, 18 Dec 2025 08:10:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
 platform-driver-x86@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Dale Whinham <daleyo@gmail.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, ath12k@lists.infradead.org, 
 Johannes Berg <johannes@sipsolutions.net>
To: =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
In-Reply-To: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
References: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
Message-Id: <176606698373.3970194.13819697961201913402.robh@kernel.org>
Subject: Re: [PATCH v3 0/6] Microsoft Surface Pro 11 support


On Thu, 18 Dec 2025 00:56:36 +0100, Jérôme de Bretagne wrote:
> This series brings support for the Qualcomm-based Microsoft Surface
> Pro 11 covering both the OLED and LCD variants.
> 
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---
> Changes in v3:
> - Update the compatible strings to document both the OLED and LCD variants
> - Move the disable-rfkill property into ieee80211.yaml [Rob,Krzysztof]
> - Reference commit c6a7c0b09d5f and detail the disable-rfkill patch description [Rob,Krzysztof]
> - Switch to the renamed hamoa.dtsi and hamoa-pmics.dtsi [Dale]
> - Improve the comments describing the 2 USB Type-C port location
> - Update the speaker definition to describe only 2-speakers [Konrad]
> - Drop output-low from the speaker definition [Konrad]
> - Enable i2c0 to make it accessible through i2c-tools [Konrad]
> - Delete a non-applicable comment about removable WLAN card [Konrad]
> - Re-order a few nodes and fix indentation issues [Konrad]
> - Squash one of the patches as suggested [Krzysztof]
> - Drop the NAKed patch patch about a dpcd link rate quirk [Dmitry]
> - Include the Reviewed-by: tags
> - Link to v2: https://lore.kernel.org/all/20251201011457.17422-1-daleyo@gmail.com/
> 
> Changes in v2:
>   - Dropped ATNA30DW01 patch as it was merged.
>   - Split device tree into x1e (OLED)/x1p (LCD) specific *.dts files and move common code into x1-microsoft-denali.dtsi (patch 4).
>   - Device tree now enables higher external monitor refresh rates/resolutions (patch 4).
>   - Device tree now enables partially working audio output; requires alsa-ucm-conf and audioreach-topology definitions in userspace (patch 4).
>   - Replaced 'Work around bogus maximum link rate' with a quirk-based approach (patch 5).
>   - Improve the commit message about the disable-rfkill property in response to feedback (patch 6).
> 
> ---
> Dale Whinham (4):
>       firmware: qcom: scm: allow QSEECOM on Surface Pro 11
>       platform/surface: aggregator_registry: Add Surface Pro 11
>       arm64: dts: qcom: Add support for Surface Pro 11
>       wifi: ath12k: Add support for disabling rfkill via devicetree
> 
> Jérôme de Bretagne (2):
>       dt-bindings: arm: qcom: Document Microsoft Surface Pro 11
>       dt-bindings: wireless: ieee80211: Add disable-rfkill property
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |    8 +
>  .../bindings/net/wireless/ieee80211.yaml           |    6 +
>  arch/arm64/boot/dts/qcom/Makefile                  |    4 +
>  arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi  | 1326 ++++++++++++++++++++
>  .../dts/qcom/x1e80100-microsoft-denali-oled.dts    |   20 +
>  .../boot/dts/qcom/x1p64100-microsoft-denali.dts    |   16 +
>  drivers/firmware/qcom/qcom_scm.c                   |    1 +
>  drivers/net/wireless/ath/ath12k/core.c             |    3 +
>  .../platform/surface/surface_aggregator_registry.c |   18 +
>  9 files changed, 1402 insertions(+)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251218-surface-sp11-for-next-626e327f7b33
> 
> Best regards,
> --
> Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: 8f0b4cce4481fb22653697cced8d0d04027cb1e8 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com:

arch/arm64/boot/dts/qcom/x1e80100-microsoft-denali-oled.dtb: / (microsoft,denali-oled): compatible: 'oneOf' conditional failed, one must be fixed:
	['microsoft,denali-oled', 'microsoft,denali', 'qcom,x1e80100'] is too long
	['microsoft,denali-oled', 'microsoft,denali', 'qcom,x1e80100'] is too short
	'microsoft,denali-oled' is not one of ['qcom,apq8016-sbc', 'schneider,apq8016-hmibsc']
	'microsoft,denali-oled' is not one of ['asus,sparrow', 'huawei,sturgeon', 'lg,lenok', 'samsung,matisse-wifi', 'samsung,milletwifi']
	'microsoft,denali-oled' is not one of ['asus,nexus7-flo', 'lg,nexus4-mako', 'sony,xperia-yuga', 'qcom,apq8064-cm-qs600', 'qcom,apq8064-ifc6410']
	'microsoft,denali-oled' is not one of ['qcom,apq8074-dragonboard']
	'microsoft,denali-oled' is not one of ['qcom,apq8060-dragonboard', 'qcom,msm8660-surf']
	'microsoft,denali-oled' is not one of ['qcom,apq8084-mtp', 'qcom,apq8084-sbc']
	'microsoft,denali-oled' is not one of ['microsoft,dempsey', 'microsoft,makepeace', 'microsoft,moneypenny', 'motorola,falcon', 'samsung,ms013g', 'samsung,s3ve3g']
	'microsoft,denali-oled' is not one of ['htc,memul', 'microsoft,superman-lte', 'microsoft,tesla', 'motorola,peregrine', 'samsung,matisselte']
	'microsoft,denali-oled' is not one of ['wingtech,wt82918hd']
	'microsoft,denali-oled' is not one of ['asus,z00t', 'huawei,kiwi', 'longcheer,l9100', 'samsung,a7', 'sony,kanuti-tulip', 'square,apq8039-t2', 'wingtech,wt82918', 'wingtech,wt82918hdhw39']
	'microsoft,denali-oled' is not one of ['sony,kugo-row', 'sony,suzu-row']
	'microsoft,denali-oled' is not one of ['qcom,msm8960-cdp', 'samsung,expressatt']
	'microsoft,denali-oled' is not one of ['sony,huashan']
	'microsoft,denali-oled' is not one of ['lge,hammerhead', 'samsung,hlte', 'sony,xperia-amami', 'sony,xperia-honami', 'sony,xperia-togari']
	'microsoft,denali-oled' is not one of ['fairphone,fp2', 'htc,m8', 'oneplus,bacon', 'samsung,klte', 'sony,xperia-aries', 'sony,xperia-castor', 'sony,xperia-leo']
	'microsoft,denali-oled' is not one of ['samsung,kltechn']
	'microsoft,denali-oled' is not one of ['longcheer,l9360']
	'microsoft,denali-oled' is not one of ['acer,a1-724', 'alcatel,idol347', 'asus,z00l', 'gplus,fl8005a', 'huawei,g7', 'lg,c50', 'lg,m216', 'longcheer,l8910', 'longcheer,l8150', 'motorola,harpia', 'motorola,osprey', 'motorola,surnia', 'qcom,msm8916-mtp', 'samsung,a3u-eur', 'samsung,a5u-eur', 'samsung,e5', 'samsung,e7', 'samsung,fortuna3g', 'samsung,gprimeltecan', 'samsung,grandmax', 'samsung,grandprimelte', 'samsung,gt510', 'samsung,gt58', 'samsung,j3ltetw', 'samsung,j5', 'samsung,j5x', 'samsung,rossa', 'samsung,serranove', 'thwc,uf896', 'thwc,ufi001c', 'wingtech,wt86518', 'wingtech,wt86528', 'wingtech,wt88047', 'yiming,uz801-v3']
	'microsoft,denali-oled' is not one of ['xiaomi,riva']
	'microsoft,denali-oled' is not one of ['xiaomi,land']
	'microsoft,denali-oled' is not one of ['flipkart,rimob', 'motorola,potter', 'xiaomi,daisy', 'xiaomi,mido', 'xiaomi,tissot', 'xiaomi,vince']
	'microsoft,denali-oled' is not one of ['lg,bullhead', 'lg,h815', 'microsoft,talkman', 'xiaomi,libra']
	'microsoft,denali-oled' is not one of ['sony,karin_windy']
	'microsoft,denali-oled' is not one of ['huawei,angler', 'microsoft,cityman', 'sony,ivy-row', 'sony,karin-row', 'sony,satsuki-row', 'sony,sumire-row', 'sony,suzuran-row']
	'microsoft,denali-oled' is not one of ['arrow,apq8096-db820c', 'inforce,ifc6640']
	'microsoft,denali-oled' is not one of ['oneplus,oneplus3', 'oneplus,oneplus3t', 'qcom,msm8996-mtp', 'sony,dora-row', 'sony,kagura-row', 'sony,keyaki-row', 'xiaomi,gemini']
	'microsoft,denali-oled' is not one of ['xiaomi,natrium', 'xiaomi,scorpio']
	'microsoft,denali-oled' is not one of ['asus,novago-tp370ql', 'fxtec,pro1', 'hp,envy-x2', 'lenovo,miix-630', 'oneplus,cheeseburger', 'oneplus,dumpling', 'qcom,msm8998-mtp', 'sony,xperia-lilac', 'sony,xperia-maple', 'sony,xperia-poplar', 'xiaomi,sagit']
	'microsoft,denali-oled' is not one of ['8dev,jalapeno', 'alfa-network,ap120c-ac']
	'microsoft,denali-oled' is not one of ['qcom,ipq4019-ap-dk01.1-c1', 'qcom,ipq4019-ap-dk04.1-c3', 'qcom,ipq4019-ap-dk07.1-c1', 'qcom,ipq4019-ap-dk07.1-c2', 'qcom,ipq4019-dk04.1-c1']
	'microsoft,denali-oled' is not one of ['qcom,ipq5018-rdp432-c2', 'tplink,archer-ax55-v1']
	'microsoft,denali-oled' is not one of ['qcom,ipq5332-ap-mi01.2', 'qcom,ipq5332-ap-mi01.3', 'qcom,ipq5332-ap-mi01.6', 'qcom,ipq5332-ap-mi01.9']
	'microsoft,denali-oled' is not one of ['qcom,ipq5424-rdp466']
	'microsoft,denali-oled' is not one of ['mikrotik,rb3011', 'qcom,ipq8064-ap148']
	'microsoft,denali-oled' is not one of ['qcom,ipq8074-hk01', 'qcom,ipq8074-hk10-c1', 'qcom,ipq8074-hk10-c2']
	'microsoft,denali-oled' is not one of ['qcom,ipq9574-ap-al02-c2', 'qcom,ipq9574-ap-al02-c6', 'qcom,ipq9574-ap-al02-c7', 'qcom,ipq9574-ap-al02-c8', 'qcom,ipq9574-ap-al02-c9']
	'swir,mangoh-green-wp8548' was expected
	'microsoft,denali-oled' is not one of ['qcom,qrb2210-rb1']
	'microsoft,denali-oled' is not one of ['fairphone,fp5', 'particle,tachyon', 'qcom,qcm6490-idp', 'qcom,qcs6490-rb3gen2', 'radxa,dragon-q6a', 'shift,otter']
	'microsoft,denali-oled' is not one of ['qcom,qdu1000-idp', 'qcom,qdu1000-x100']
	'microsoft,denali-oled' is not one of ['qcom,qru1000-idp']
	'microsoft,denali-oled' is not one of ['qcom,qar2130p']
	'microsoft,denali-oled' is not one of ['acer,aspire1', 'qcom,sc7180-idp']
	'google,coachz-rev1' was expected
	'google,coachz' was expected
	'google,coachz-rev1-sku0' was expected
	'google,coachz-sku0' was expected
	'google,homestar-rev2' was expected
	'google,homestar-rev3' was expected
	'google,homestar' was expected
	'google,kingoftown-rev0' was expected
	'google,kingoftown' was expected
	'google,lazor-rev0' was expected
	'google,lazor-rev1' was expected
	'google,lazor-rev3' was expected
	'google,lazor-rev9' was expected
	'google,lazor' was expected
	'google,lazor-rev1-sku2' was expected
	'google,lazor-rev3-sku2' was expected
	'google,lazor-rev9-sku2' was expected
	'google,lazor-sku2' was expected
	'google,lazor-rev1-sku0' was expected
	'google,lazor-rev3-sku0' was expected
	'google,lazor-rev9-sku0' was expected
	'google,lazor-sku0' was expected
	'google,lazor-rev4-sku4' was expected
	'google,lazor-rev9-sku4' was expected
	'google,lazor-sku4' was expected
	'google,lazor-rev4-sku5' was expected
	'google,lazor-rev5-sku5' was expected
	'google,lazor-rev9-sku6' was expected
	'google,lazor-sku6' was expected
	'google,mrbland-rev0-sku0' was expected
	'google,mrbland-sku1536' was expected
	'google,mrbland-rev0-sku16' was expected
	'google,mrbland-sku1024' was expected
	'google,pazquel-sku5' was expected
	'google,pazquel-sku1' was expected
	'google,pazquel-sku6' was expected
	'google,pazquel-sku0' was expected
	'google,pazquel-sku22' was expected
	'google,pazquel-sku21' was expected
	'google,pompom-rev1' was expected
	'google,pompom-rev2' was expected
	'google,pompom' was expected
	'google,pompom-rev1-sku0' was expected
	'google,pompom-rev2-sku0' was expected
	'google,pompom-sku0' was expected
	'google,quackingstick-sku1537' was expected
	'google,quackingstick-sku1536' was expected
	'google,trogdor' was expected
	'google,trogdor-sku0' was expected
	'google,wormdingler-rev0-sku16' was expected
	'google,wormdingler-sku1024' was expected
	'google,wormdingler-sku1025' was expected
	'google,wormdingler-rev0-sku0' was expected
	'google,wormdingler-sku0' was expected
	'google,wormdingler-sku1' was expected
	'qcom,sc7280-crd' was expected
	'google,zoglin' was expected
	'google,zoglin-sku1536' was expected
	'qcom,sc7280-idp' was expected
	'qcom,sc7280-idp2' was expected
	'google,evoker' was expected
	'google,evoker-sku512' was expected
	'google,herobrine' was expected
	'google,villager-rev0' was expected
	'google,villager' was expected
	'google,villager-sku512' was expected
	'google,zombie' was expected
	'google,zombie-sku512' was expected
	'google,zombie-sku2' was expected
	'google,zombie-sku514' was expected
	'microsoft,denali-oled' is not one of ['lenovo,flex-5g', 'microsoft,surface-prox', 'qcom,sc8180x-primus']
	'microsoft,denali-oled' is not one of ['huawei,gaokun3', 'lenovo,thinkpad-x13s', 'microsoft,arcata', 'microsoft,blackrock', 'qcom,sc8280xp-crd', 'qcom,sc8280xp-qrd']
	'microsoft,denali-oled' is not one of ['lenovo,tbx605f', 'motorola,ali']
	'microsoft,denali-oled' is not one of ['sony,discovery-row', 'sony,kirin-row', 'sony,pioneer-row', 'sony,voyager-row']
	'microsoft,denali-oled' is not one of ['inforce,ifc6560']
	'microsoft,denali-oled' is not one of ['fairphone,fp3', 'motorola,ocean']
	'microsoft,denali-oled' is not one of ['sony,mermaid-row']
	'microsoft,denali-oled' is not one of ['xiaomi,lavender']
	'microsoft,denali-oled' is not one of ['google,sargo']
	'microsoft,denali-oled' is not one of ['qcom,sdx55-mtp', 'qcom,sdx55-telit-fn980-tlb', 'qcom,sdx55-t55']
	'microsoft,denali-oled' is not one of ['qcom,sdx65-mtp']
	'microsoft,denali-oled' is not one of ['qcom,sdx75-idp']
	'microsoft,denali-oled' is not one of ['qcom,ipq6018-cp01', 'qcom,ipq6018-cp01-c1']
	'microsoft,denali-oled' is not one of ['qcom,qcs404-evb-1000', 'qcom,qcs404-evb-4000']
	'microsoft,denali-oled' is not one of ['qcom,monaco-evk', 'qcom,qcs8300-ride']
	'microsoft,denali-oled' is not one of ['qcom,qcs615-ride']
	'microsoft,denali-oled' is not one of ['qcom,sa8155p-adp']
	'microsoft,denali-oled' is not one of ['qcom,sa8295p-adp', 'qcom,sa8540p-ride']
	'microsoft,denali-oled' is not one of ['qcom,sa8775p-ride', 'qcom,sa8775p-ride-r3']
	'microsoft,denali-oled' is not one of ['qcom,lemans-evk', 'qcom,qcs9100-ride', 'qcom,qcs9100-ride-r3']
	'microsoft,denali-oled' is not one of ['huawei,planck', 'lenovo,yoga-c630', 'lg,judyln', 'lg,judyp', 'oneplus,enchilada', 'oneplus,fajita', 'qcom,sdm845-mtp', 'shift,axolotl', 'samsung,starqltechn', 'samsung,w737', 'sony,akari-row', 'sony,akatsuki-row', 'sony,apollo-row', 'thundercomm,db845c', 'xiaomi,beryllium', 'xiaomi,beryllium-ebbg', 'xiaomi,polaris']
	'microsoft,denali-oled' is not one of ['oneplus,billie2']
	'microsoft,denali-oled' is not one of ['qcom,qrb4210-rb2']
	'microsoft,denali-oled' is not one of ['qcom,sm4450-qrd']
	'microsoft,denali-oled' is not one of ['fxtec,pro1x']
	'microsoft,denali-oled' is not one of ['lenovo,j606f']
	'microsoft,denali-oled' is not one of ['sony,pdx201', 'xiaomi,ginkgo', 'xiaomi,laurel-sprout']
	'microsoft,denali-oled' is not one of ['sony,pdx213']
	'microsoft,denali-oled' is not one of ['sony,pdx225']
	'microsoft,denali-oled' is not one of ['xiaomi,curtana', 'xiaomi,joyeuse']
	'microsoft,denali-oled' is not one of ['google,sunfish']
	'microsoft,denali-oled' is not one of ['fairphone,fp4']
	'microsoft,denali-oled' is not one of ['nothing,spacewar']
	'microsoft,denali-oled' is not one of ['microsoft,surface-duo', 'qcom,sm8150-hdk', 'qcom,sm8150-mtp', 'sony,bahamut-generic', 'sony,griffin-generic']
	'microsoft,denali-oled' is not one of ['qcom,qrb5165-rb5', 'qcom,sm8250-hdk', 'qcom,sm8250-mtp', 'samsung,r8q', 'samsung,x1q', 'sony,pdx203-generic', 'sony,pdx206-generic', 'xiaomi,elish', 'xiaomi,pipa']
	'microsoft,denali-oled' is not one of ['microsoft,surface-duo2', 'qcom,sm8350-hdk', 'qcom,sm8350-mtp', 'sony,pdx214-generic', 'sony,pdx215-generic']
	'microsoft,denali-oled' is not one of ['qcom,sm8450-hdk', 'qcom,sm8450-qrd', 'samsung,r0q', 'sony,pdx223', 'sony,pdx224']
	'microsoft,denali-oled' is not one of ['qcom,sm8550-hdk', 'qcom,sm8550-mtp', 'qcom,sm8550-qrd', 'samsung,q5q', 'sony,pdx234']
	'microsoft,denali-oled' is not one of ['qcom,qcs8550-aim300-aiot']
	'microsoft,denali-oled' is not one of ['qcom,sm8650-hdk', 'qcom,sm8650-mtp', 'qcom,sm8650-qrd']
	'microsoft,denali-oled' is not one of ['qcom,sm8750-mtp', 'qcom,sm8750-qrd']
	'microsoft,denali-oled' is not one of ['qcom,x1e001de-devkit']
	'microsoft,denali-oled' is not one of ['lenovo,thinkpad-t14s-lcd', 'lenovo,thinkpad-t14s-oled']
	'microsoft,denali-oled' is not one of ['asus,vivobook-s15', 'asus,zenbook-a14-ux3407ra', 'dell,inspiron-14-plus-7441', 'dell,latitude-7455', 'dell,xps13-9345', 'hp,elitebook-ultra-g1q', 'hp,omnibook-x14', 'lenovo,yoga-slim7x', 'microsoft,romulus13', 'microsoft,romulus15', 'qcom,x1e80100-crd', 'qcom,x1e80100-qcp']
	'microsoft,denali-oled' is not one of ['qcom,hamoa-iot-evk']
	'microsoft,denali-oled' is not one of ['asus,zenbook-a14-ux3407qa-lcd', 'asus,zenbook-a14-ux3407qa-oled']
	'microsoft,denali-oled' is not one of ['hp,omnibook-x14-fe1', 'lenovo,thinkbook-16', 'qcom,x1p42100-crd']
	'qcom,apq8016' was expected
	'qcom,apq8026' was expected
	'qcom,apq8064' was expected
	'qcom,apq8074' was expected
	'qcom,msm8660' was expected
	'qcom,apq8084' was expected
	'qcom,msm8226' was expected
	'qcom,msm8926' was expected
	'qcom,msm8929' was expected
	'qcom,msm8939' was expected
	'qcom,msm8956' was expected
	'qcom,msm8960' was expected
	'qcom,msm8960t' was expected
	'qcom,msm8974' was expected
	'qcom,msm8974pro' was expected
	'samsung,klte' was expected
	'qcom,msm8976' was expected
	'qcom,msm8916' was expected
	'qcom,msm8917' was expected
	'qcom,msm8937' was expected
	'qcom,msm8953' was expected
	'qcom,msm8992' was expected
	'qcom,apq8094' was expected
	'qcom,msm8994' was expected
	'qcom,apq8096-sbc' was expected
	'qcom,msm8996' was expected
	'qcom,msm8996pro' was expected
	'qcom,msm8998' was expected
	'qcom,ipq4018' was expected
	'qcom,ipq4019' was expected
	'qcom,ipq5018' was expected
	'qcom,ipq5332' was expected
	'qcom,ipq5424' was expected
	'qcom,ipq8064' was expected
	'qcom,ipq8074' was expected
	'qcom,ipq9574' was expected
	'swir,wp8548' was expected
	'qcom,qrb2210' was expected
	'qcom,qcm6490' was expected
	'qcom,qdu1000' was expected
	'qcom,qru1000' was expected
	'qcom,sar2130p' was expected
	'qcom,sc7180' was expected
	'google,coachz-rev2' was expected
	'google,coachz-rev2-sku0' was expected
	'google,homestar-rev23' was expected
	'google,lazor-rev2' was expected
	'google,lazor-rev4' was expected
	'google,lazor-rev2-sku2' was expected
	'google,lazor-rev4-sku2' was expected
	'google,lazor-rev2-sku0' was expected
	'google,lazor-rev4-sku0' was expected
	'google,lazor-rev9-sku10' was expected
	'google,lazor-sku10' was expected
	'google,lazor-rev5-sku4' was expected
	'google,lazor-rev9-sku15' was expected
	'google,lazor-sku15' was expected
	'google,lazor-rev5-sku6' was expected
	'google,lazor-rev9-sku18' was expected
	'google,lazor-sku18' was expected
	'google,mrbland-sku768' was expected
	'google,pazquel-sku4' was expected
	'google,pazquel-sku2' was expected
	'google,pazquel-sku20' was expected
	'google,hoglin-rev3' was expected
	'google,hoglin' was expected
	'google,hoglin-sku1536' was expected
	'google,senor' was expected
	'google,piglin' was expected
	'qcom,sc7280' was expected
	'google,zombie-sku3' was expected
	'qcom,sc8180x' was expected
	'qcom,sc8280xp' was expected
	'qcom,sdm450' was expected
	'qcom,sdm630' was expected
	'qcom,sda660' was expected
	'qcom,sdm632' was expected
	'qcom,sdm636' was expected
	'qcom,sdm660' was expected
	'qcom,sdm670' was expected
	'qcom,sdx55' was expected
	'qcom,sdx65' was expected
	'qcom,sdx75' was expected
	'qcom,ipq6018' was expected
	'qcom,qcs404-evb' was expected
	'qcom,qcs8300' was expected
	'qcom,qcs615' was expected
	'qcom,sa8155p' was expected
	'qcom,sa8540p' was expected
	'qcom,sa8775p' was expected
	'qcom,qcs9100' was expected
	'qcom,sdm845' was expected
	'qcom,sm4250' was expected
	'qcom,qrb4210' was expected
	'qcom,sm4450' was expected
	'qcom,sm6115' was expected
	'qcom,sm6115p' was expected
	'qcom,sm6125' was expected
	'qcom,sm6350' was expected
	'qcom,sm6375' was expected
	'qcom,sm7125' was expected
	'qcom,sm7150' was expected
	'qcom,sm7225' was expected
	'qcom,sm7325' was expected
	'qcom,sm8150' was expected
	'qcom,sm8250' was expected
	'qcom,sm8350' was expected
	'qcom,sm8450' was expected
	'qcom,sm8550' was expected
	'qcom,qcs8550-aim300' was expected
	'qcom,sm8650' was expected
	'qcom,sm8750' was expected
	'qcom,x1e001de' was expected
	'lenovo,thinkpad-t14s' was expected
	'qcom,x1e80100' was expected
	'qcom,hamoa-iot-som' was expected
	'asus,zenbook-a14-ux3407qa' was expected
	'qcom,x1p42100' was expected
	'qcom,apq8096' was expected
	'qcom,mdm9615' was expected
	'qcom,qcm2290' was expected
	'google,lazor-rev5' was expected
	'google,lazor-rev5-sku2' was expected
	'google,lazor-rev5-sku0' was expected
	'google,lazor-rev6-sku4' was expected
	'google,lazor-rev6-sku6' was expected
	'google,hoglin-rev4' was expected
	'google,zombie-sku515' was expected
	'qcom,qcs404' was expected
	'qcom,sm6150' was expected
	'qcom,qcs8550' was expected
	'qcom,x1e78100' was expected
	'qcom,x1p64100' was expected
	from schema $id: http://devicetree.org/schemas/arm/qcom.yaml
arch/arm64/boot/dts/qcom/x1e80100-microsoft-denali-oled.dtb: wifi@0 (pci17cb,1107): 'disable-rfkill' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml
arch/arm64/boot/dts/qcom/x1p64100-microsoft-denali.dtb: wifi@0 (pci17cb,1107): 'disable-rfkill' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml






