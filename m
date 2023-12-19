Return-Path: <linux-wireless+bounces-993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527758188FD
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 14:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D642E1F255C0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD051B27B;
	Tue, 19 Dec 2023 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcwICVwl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9391A72F
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42782601608so155181cf.2
        for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 05:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702993887; x=1703598687; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTFV7JJq/mmtCsGfFXzITv3h5Nljdw/pT1c5FOrQNFg=;
        b=dcwICVwln3+v0tFZjxYJvIYcn44UXwk2hDuTBhNKgnJpYO2VdB1OqxrK0vi9Oqz6wE
         65i9t+BQ2zDmeFGTFvPV1yxBiPg3AHwlWOmeEmuoVhvv/tObXxNv4PSweUj54l/Ccb7n
         dm5kAtq/+vA6eZZXM1HhDulbZDZRxC/22R+mVlpSG1hIwq1WR/NytH8SaKwHmFjtf08L
         wVsNg2HckAPpVyt3WWH3vF9wcJW9U/+vNgYtK6mZQntsSkGc8hoheNgTxWaUzG6Be17g
         T2qRIrblKfL8atDiq4iaOqhd8k8s8E3cCAJiL6IfEhc06PR1GYCWfQdIZN768cdCLvD4
         Do/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702993887; x=1703598687;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iTFV7JJq/mmtCsGfFXzITv3h5Nljdw/pT1c5FOrQNFg=;
        b=sJX64AXaDs59YT7Fuhj3W3BEJQQo7DacZmaOATRpPlQgBHa9QVh9dtLgpOpSk+0aUg
         U6SfUgf/j7BBIT1lUWAsB/094BKI+H8tICEmvMRc1jM9fHI6F3HUfCtUM8jI77t8N0+9
         O0ImStO1IocrAoAFUlMUYKiXvE9ar3DqTSnmOICJPtn8xXp4sEXurGQQPVqp8OfcQJJh
         IYaXSswTTska2HlMfEbv6C9CzBTc5sBuXhPFyhb1BNxcWcKFy9O67qKITEBP4jYO6P/M
         Wg2WM9BiFksy1GRwAAAhseXSwXm/YT7Qpmd3LPVpNLhCHPf5ZROYozTfSW2k6jbmySL7
         /3vw==
X-Gm-Message-State: AOJu0YykX6ZwhM2ODRC1rL7A9ZV+fgX/CUYMsnJUlWIuoyu2uu7c2wWy
	W4amIycPVnj0WAJs6eda8Uc4gXFFJzY=
X-Google-Smtp-Source: AGHT+IHfqym+D9e2n1fzXmbLK767HPyHSLyQnoZ6eaos+0UkUk6xBJe6L1CyCUseCYY2rwAOMzL6BA==
X-Received: by 2002:a05:622a:190d:b0:425:4043:8d52 with SMTP id w13-20020a05622a190d00b0042540438d52mr15351675qtc.109.1702993886613;
        Tue, 19 Dec 2023 05:51:26 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ef8-20020a05622a53c800b0042753a7ada2sm2787200qtb.85.2023.12.19.05.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 05:51:26 -0800 (PST)
Message-ID: <ab00ff77-23de-43a1-9eb9-6ac036ab80e3@gmail.com>
Date: Tue, 19 Dec 2023 05:51:24 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: ath11k@lists.infradead.org
From: James Prestwood <prestwoj@gmail.com>
Subject: Ath11k warnings, and eventual phy going away requiring reboot
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I noticed this after one of our devices dropped offline. The device had 
roamed 7 minutes prior so I doubt that had anything to do with it. But 
then we get this, and then tons of warnings. I'm happy to provide full 
stack traces but its quite a few, not sure which ones are relevant or 
not. After all the warnings IWD got an RTNL del link event and was 
unable to recover from that. It seems after that ath11k tried to power 
back on but failed.

This is a stock 6.2 ubuntu kernel, WCN6855:

fw_version 0x1106996e fw_build_timestamp 2023-10-13 07:30 fw_build_id 
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

I see there is a new FW as of 5 days ago, so I could try that if you 
think this is a FW problem.

Dec 19 11:53:33 kernel: ieee80211 phy0: Hardware restart was requested
Dec 19 11:53:33 kernel: mhi mhi0: Requested to power ON
Dec 19 11:53:33 kernel: mhi mhi0: Power on setup success
Dec 19 11:53:34 kernel: mhi mhi0: Wait for device to enter SBL or 
Mission mode
Dec 19 11:53:34 kernel: ath11k_pci 0000:01:00.0: already resetting count 2
Dec 19 11:53:43 kernel: ath11k_pci 0000:01:00.0: failed to send 
WMI_PDEV_SET_PARAM cmd
Dec 19 11:53:43 kernel: ath11k_pci 0000:01:00.0: failed to enable PMF 
QOS: (-108
Dec 19 11:53:43 kernel: Hardware became unavailable during restart.
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/util.c:2555 ieee80211_reconfig+0x505/0x1100 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.h:627 drv_flush+0x16f/0x180 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.h:839 drv_mgd_complete_tx+0x169/0x190 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.c:399 drv_ampdu_action+0x176/0x1a0 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.h:508 drv_sta_pre_rcu_remove+0x15f/0x180 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.c:120 drv_sta_state+0x226/0x230 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/sta_info.c:1291 __sta_info_destroy_part2+0x19b/0x1b0 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.c:462 drv_set_key+0x1d5/0x1e0 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/sta_info.c:1308 __sta_info_destroy_part2+0x15a/0x1b0 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/sta_info.c:1316 __sta_info_destroy_part2+0x17f/0x1b0 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.h:555 drv_sta_statistics+0x160/0x180 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/sta_info.c:417 sta_info_free+0xf4/0x170 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/sta_info.c:420 sta_info_free+0x162/0x170 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/main.c:235 ieee80211_bss_info_change_notify+0x2dd/0x2f0 
[mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.c:193 drv_conf_tx+0x1e5/0x250 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.c:316 drv_unassign_vif_chanctx+0x19d/0x1d0 
[mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.h:156 
ieee80211_vif_cfg_change_notify+0x19c/0x1b0 [mac80211]
Dec 19 11:53:43 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.h:888 ieee80211_del_chanctx+0x1d6/0x1e0 [mac80211]
Dec 19 11:53:48 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.c:99 drv_remove_interface+0x137/0x150 [mac80211]
Dec 19 11:53:48 kernel: WARNING: CPU: 1 PID: 1328948 at 
net/mac80211/driver-ops.c:38 drv_stop+0x10f/0x120 [mac80211]
Dec 19 11:53:48 iwd[490]: src/station.c:station_enter_state() Old State: 
autoconnect_quick, new state: autoconnect_full
Dec 19 11:53:48 iwd[490]: src/scan.c:scan_periodic_start() Starting 
periodic scan for wdev 2
Dec 19 11:53:48 iwd[490]: src/wiphy.c:wiphy_radio_work_insert() 
Inserting work item 1466
Dec 19 11:53:48 iwd[490]: src/wiphy.c:wiphy_radio_work_done() Work item 
1465 done
Dec 19 11:53:48 iwd[490]: src/wiphy.c:wiphy_radio_work_next() Starting 
work item 1466
Dec 19 11:53:48 iwd[490]: Received error during CMD_TRIGGER_SCAN: 
Network is down (100)
Dec 19 11:53:48 iwd[490]: src/netdev.c:netdev_link_notify() event 16 on 
ifindex 5
Dec 19 11:53:48 iwd[490]: src/station.c:station_free()
Dec 19 11:53:48 iwd[490]: src/netconfig.c:netconfig_destroy()
Dec 19 11:53:48 iwd[490]: src/scan.c:scan_periodic_stop() Stopping 
periodic scan for wdev 2
Dec 19 11:53:48 iwd[490]: src/scan.c:scan_cancel() Trying to cancel scan 
id 1466 for wdev 2
Dec 19 11:53:48 iwd[490]: src/scan.c:scan_cancel() Scan is already started
Dec 19 11:53:48 iwd[490]: src/wiphy.c:wiphy_radio_work_done() Work item 
1466 done
Dec 19 11:53:48 iwd[490]: src/station.c:station_roam_state_clear() 5
Dec 19 11:53:55 kernel: qcom_mhi_qrtr mhi0_IPCR: 20: Failed to receive 
START channel command completion
Dec 19 11:53:55 kernel: qcom_mhi_qrtr: probe of mhi0_IPCR failed with 
error -5
Dec 19 11:54:16 kernel: mhi mhi0: Requested to power ON
Dec 19 11:54:16 kernel: mhi mhi0: Power on setup success
Dec 19 11:54:45 kernel: mhi mhi0: Device failed to enter MHI Ready
Dec 19 11:54:45 kernel: mhi mhi0: MHI did not enter READY state
Dec 19 11:54:45 kernel: ath11k_pci 0000:01:00.0: failed to power up mhi: 
-110
Dec 19 11:54:45 kernel: ath11k_pci 0000:01:00.0: failed to start mhi: -110
Dec 19 11:54:45 kernel: ath11k_pci 0000:01:00.0: already resetting count 3
Dec 19 11:55:27 kernel: mhi mhi0: Requested to power ON
Dec 19 11:55:27 kernel: mhi mhi0: Power on setup success
Dec 19 11:55:57 kernel: mhi mhi0: Device failed to enter MHI Ready
Dec 19 11:55:57 kernel: mhi mhi0: MHI did not enter READY state
Dec 19 11:55:57 kernel: ath11k_pci 0000:01:00.0: failed to power up mhi: 
-110
Dec 19 11:55:57 kernel: ath11k_pci 0000:01:00.0: failed to start mhi: -110
Dec 19 12:15:25 kernel: usb 4-1: USB disconnect, device number 3

Thanks,

James


