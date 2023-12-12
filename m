Return-Path: <linux-wireless+bounces-717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E1180FA1F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 23:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A751F21825
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 22:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33026660E3;
	Tue, 12 Dec 2023 22:18:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E149C;
	Tue, 12 Dec 2023 14:18:43 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d319a7a35bso25037715ad.1;
        Tue, 12 Dec 2023 14:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419523; x=1703024323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvY1eWl3lKFXHEN46vG5hFlccI2oevea3+BmMQLJsrc=;
        b=Sil14H59nmgOl1bCG252KjNzigSfW5HNV0fmWcIm1fdr0pfoe+ssjvZWzDY56aokdc
         4ciAbTXioTPbczo8+Ha4ONDrjeDUSsa6r35hcz6c6YSQ7K0pVvcev5zEazWMoLTObfPm
         C/fhW35RLdW8JhdPygc4z0ijvW85gKt8hFxYH2IfQK424Cxcv3NPjBaMq9gfkeecXldk
         8gA9JnquK07whHThUhX9QIBnv8OSbQ2bVNnKDDeKi6469aLKf3dLOOqGSx3rnRBVKIgC
         gWGiQHBt7SHkaS74ZS2y6MkhI81prVVwJ6r0c74vFt4BUsmPETD2sDZDctAGRxNuo0p5
         20BQ==
X-Gm-Message-State: AOJu0YxICo21o/x4xL6+wZ8gxFHqE1gwV6kcdgdFDZRG+OOCIThaTwI5
	Fo8z78cW16DO76fUiDR+Zoc=
X-Google-Smtp-Source: AGHT+IGauSeo8T0m4lPBuVMy5qhZ3L6G9zLsDODSHevJyslBAa9OfC/TfMPkPD2KsM2lLP2jOkCLNQ==
X-Received: by 2002:a17:902:e54b:b0:1d0:796c:b06d with SMTP id n11-20020a170902e54b00b001d0796cb06dmr8010754plf.7.1702419523173;
        Tue, 12 Dec 2023 14:18:43 -0800 (PST)
Received: from sultan-box.localdomain ([142.147.89.200])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902704800b001d0c09cc6ebsm9127532plt.92.2023.12.12.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:18:42 -0800 (PST)
Date: Tue, 12 Dec 2023 14:18:39 -0800
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Ben Greear <greearb@candelatech.com>,
	"open list:MEDIATEK MT76 WIRELESS LAN DRIVER" <linux-wireless@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
Message-ID: <ZXjcPyIgWzKWyBQ8@sultan-box.localdomain>
References: <20231212090852.162787-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212090852.162787-1-mario.limonciello@amd.com>

On Tue, Dec 12, 2023 at 03:08:51AM -0600, Mario Limonciello wrote:
> Several users have reported awful latency when powersaving is enabled
> with certain access point combinations. It's also reported that the
> powersaving feature doesn't provide an ample enough savings to justify
> being enabled by default with these issues.
> 
> Introduce a module parameter that would control the power saving
> behavior.  Set it to default as disabled. This mirrors what some other
> WLAN drivers like iwlwifi do.
> 
> Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Link: https://codeberg.org/Hybrid-Project-Developers/linux-tkg/blame/branch/master/mt76:-mt7921:-Disable-powersave-features-by-default.mypatch
> Link: https://aur.archlinux.org/cgit/aur.git/tree/0027-mt76_-mt7921_-Disable-powersave-features-by-default.patch?h=linux-g14
> Link: https://community.frame.work/t/responded-strange-wlan-problems-with-kernel-branch-6-2/41868/4
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> index 7d6a9d746011..78d4197988c8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -10,6 +10,11 @@
>  #include "../mt76_connac2_mac.h"
>  #include "mcu.h"
>  
> +static bool mt7921_powersave;
> +module_param_named(power_save, mt7921_powersave, bool, 0444);
> +MODULE_PARM_DESC(power_save,
> +		 "enable WiFi power management (default: disable)");
> +
>  static ssize_t mt7921_thermal_temp_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -271,11 +276,13 @@ int mt7921_register_device(struct mt792x_dev *dev)
>  	dev->pm.idle_timeout = MT792x_PM_TIMEOUT;
>  	dev->pm.stats.last_wake_event = jiffies;
>  	dev->pm.stats.last_doze_event = jiffies;
> -	if (!mt76_is_usb(&dev->mt76)) {
> +	if (mt7921_powersave && !mt76_is_usb(&dev->mt76)) {
>  		dev->pm.enable_user = true;
>  		dev->pm.enable = true;
>  		dev->pm.ds_enable_user = true;
>  		dev->pm.ds_enable = true;
> +	} else {
> +		hw->wiphy->flags &= ~WIPHY_FLAG_PS_ON_BY_DEFAULT;
>  	}
>  
>  	if (!mt76_is_mmio(&dev->mt76))
> -- 
> 2.34.1
> 

A few things to note:

1. Power savings can be significant on some systems where keeping the PCIe link
   active consumes significant energy (e.g., Intel HX chipsets in laptops and
   probably desktops in general). On desktops this isn't a big deal, but on
   desktop-class laptops the battery impact will be noticeable.

2. This doesn't mirror iwlwifi, which has powersave enabled by default.

   Beacon filtering is tied to powersave in mt76, whereas it isn't in iwlwifi.
   Thus, disabling powersave on mt76 results in the loss of beacon filtering.
   This means you'll get a constant stream of interrupts from beacon frames
   transmitted by the AP, which can also have power implications.

   And iwlwifi handles powersave transitions in firmware, which allows it
   enter/exit powersave with very low latency. This isn't the case on mt76,
   which enters/exits powersave in software.
   
3. For insignificant/low-bandwidth traffic like ICMP to the AP, high latency is
   expected since the amount of traffic doesn't warrant kicking the chipset out
   of powersave. So although it's not pretty to look at, bad ping times to the
   AP aren't representative of the full user experience.

That being said, given that my patch to disable powersave from over a year ago
has apparently become a commonplace addition to mt76, it seems like users
generally aren't happy with the current powersave UX. I agree that it should be
better, though I'm not certain disabling powersave outright is the best move.
Maybe the powersave behavior can be tweaked instead?

The reason I disabled powersave on my mt76 hardware was because I wanted the
lowest latency + highest throughput possible.

I know that on smartphones, QCA chipsets exhibit the same latency issue when
pinging the AP, due to powersave. But no one seems to be upset about that on
their phone, so I think there's probably a way to make powersave work well for
all parties.

Regarding the patch itself, I think a better idea would be to tie the wiphy
powersave flag to the deep sleep flag (`dev->pm.ds_enable_user`), so that users
can really disable powersave through `iw` at runtime without needing to use
debugfs. This would eliminate the need for a module parameter too.

Also, I find it quite sad that my patch from over a year ago [1] was blatantly
reauthored in that frame.work link. The commit message is even the same, word
for word. :-(

[1] https://github.com/kerneltoast/kernel_x86_laptop/commit/ca89780690f7492c2d357e0ed2213a1d027341ae

Sultan

