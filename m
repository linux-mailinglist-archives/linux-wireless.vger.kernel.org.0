Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E226587B5
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Dec 2022 00:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiL1XCN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Dec 2022 18:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL1XCL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Dec 2022 18:02:11 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866A2B1C9
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 15:02:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id fc4so41359394ejc.12
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 15:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cqFOuMocK8SD2xeNSDJcuqTg12MUb93y5r3oT3npP1o=;
        b=ObqQDhYhQEWpMCbLypEKKWmrcMAq+Gr+BAlRtlKc5oBWM9U7cUDukMkIQmuRu99wxv
         U8YP2tOJHvPQJvtuhjhPSJDWG3IGSC2BZJcalF00siVIA6c41c8gY/b2OeuAwolwlfAi
         FXUD0J7KcK0pZkdQdvFSUBM/GIqkUth35ZUCpTozU4WleI1AvETwaawXzU9oxmVQGgLC
         DB00iYTwh8fRicX4igR/VU1Si7I7C5fvmSrnzInfUXqu1wY0LJbKOaQyUOrhOhhGy7nB
         JZ+OZgK1TLD59w/o1tMP8T0I17XEmizuMvpUoBPKXVAC98XY53vXJqOV3SOV8Cnnnvgz
         bDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqFOuMocK8SD2xeNSDJcuqTg12MUb93y5r3oT3npP1o=;
        b=mCpXMPreQ4RENwQNbLtcmifms/Ue3Jpkt9EVfvHcbWglCBP7G8niTU1G18P9UfSCed
         G7dTGxcbcyXmobcihpdoQMKXzknhQlI71P6Jn+Jl+txWpIcAnP5NlOTKAoP8mwerJ6lV
         7IxM6jwMf4re1/9JiNTiuQ/NKyYZDHsG1t1eJXyoTaVpN2upmMe9sN1LoX8hlKkoSEiP
         cAyCaOoNT8k4yQPjPEg2mqK+G5EYBfMe8iE48qBm6fkBIfV32QVTYIJg6/L6YNgJDm22
         iAhl/AWXsj38hqwhM3JMLC2LsfPtyNAPmEYZPoepIIGfy4WqeMI2vDas8sENn8Ex0qrb
         IXpA==
X-Gm-Message-State: AFqh2kpRFZCRxQBV00P1VIyQFBBi/ACi52NL+v1ounmRNqoWfD/GHhWn
        2i18iw9T2fsXuC7Zpk6DeuwoXG6dhh0=
X-Google-Smtp-Source: AMrXdXsP2X8NN3HyzlsWagVzJBo64e9ZuREXE0Ee5gyjLhP72mbZPu6BGWnAl5wWY51YSOTDXawS8g==
X-Received: by 2002:a17:907:c242:b0:7c1:453f:1aae with SMTP id tj2-20020a170907c24200b007c1453f1aaemr28144323ejc.37.1672268528955;
        Wed, 28 Dec 2022 15:02:08 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id kv11-20020a17090778cb00b007b4bc423b41sm7841221ejc.190.2022.12.28.15.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 15:02:08 -0800 (PST)
Message-ID: <73344f4a-235b-5f11-e559-686ce15463e4@gmail.com>
Date:   Thu, 29 Dec 2022 01:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: rtw88: Doesn't work for 60-90 seconds several times a day
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <Ej2iRcw0tVYRZD-CNBij8Uu3T-8IG-NVQ_EUM4Oz6IstXLQn0JKvkcfec1RDYKReWdi7JbPiMTOmeihtId1j91nq_IdMWYY482HTOXecGCg=@protonmail.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <Ej2iRcw0tVYRZD-CNBij8Uu3T-8IG-NVQ_EUM4Oz6IstXLQn0JKvkcfec1RDYKReWdi7JbPiMTOmeihtId1j91nq_IdMWYY482HTOXecGCg=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21/07/2022 00:35, rtl8821cerfe2 wrote:
> Hello.
> 
> I am unable to open any sites in Firefox for 60-90 seconds at a time.
> On one occasion it was 156 seconds. Firefox gives up after 20 seconds
> or so. NetworkManager reports "limited connectivity". The router doesn't
> reply to pings. The journal shows that the laptop remains connected to
> the router. This happens several times a day.
> 
> However, my IRC client seems to be unaffected. It never detected any
> abnormally high lag during these events, not even the one that lasted
> 156 seconds. It checks the lag every 30 seconds. Also, the bot named
> "phrik" from the #archlinux-offtopic channel reacts immediately when
> I send it "!ping" during one of these events. (It sends back "pong".)
> So I guess existing connections are not affected.
> 
> I have had this problem ever since support for RTL8821CE with RFE 2
> was added. (The wifi card's RFE type is 2.)
> 
> Other devices connected to the same router don't have this problem.
> 
> The laptop and the router are in the same room. The distance
> between them is about 3 meters.
> 
> 
> These are the things I tried which did not help:
> 
> - The rtw88_core option disable_lps_deep=1
> 
> - `iw wlo1 set power_save off`
> 
> - Installing wireless-regdb and uncommenting my country in
>   /etc/conf.d/wireless-regdom
> 
> - Switching the router to "n only" mode. Previously it was in "b/g/n"
>   mode.
> 
> - Making the router use channel 9 instead of "auto". By itself it was
>   selecting channels 1 or 11 the few times I checked that. Channel 9
>   seemed less crowded than those.
> 
> - Making the router use 40 MHz channel width instead of the "20/40"
>   setting. This doubled the speed but didn't help with my problem.
> 
> - The firmware from the rtl8821ce driver [0] (version 20.1.0),
>   instead of the one from linux-firmware (version 24.11.0). I used the
>   one with the length of 137616 bytes.
> 
> This doesn't happen with the rtl8821ce driver, which is why I extracted
> that firmware from it, to see if it's a firmware issue.
> 
> 
> Pinging the router all day seems to prevent this problem. Enabling all
> the debug flags for rtw88_core also *may* prevent it. I'm not sure about
> that.
> 
> 
> Most of the time I don't have any bluetooth devices connected.
> When I do, they don't cause problems.
> 
> 
> I captured a bit of wifi traffic using another laptop, including two of
> these events, and noticed something strange:
> 
> - rtw88 sends "Null function" telling the router it's going to sleep
> - router immediately sends ack (after less than 1 ms)
> - rtw88 resends "Null function" (same SN, Retry flag set)
> - router immediately sends ack
> - rtw88 resends
> - router immediately sends ack
> - rtw88 resends
> - ...
> - ...
> 
> rtw88 resends the "Null function" 3-4 times, even though the router
> promptly sends ack each time, then it sends a new "Null function" with
> different SN and the process repeats. This seems to happen all the time,
> not just when I can't open any pages in Firefox. The rtl8821ce driver
> doesn't do this, but rtw88 with the old 20.1.0 firmware does. My phone
> doesn't do this either.
> 
> I can provide the captures in private.
> 
> 
> Currently I'm using the rtw88_pci option disable_aspm=1, because kernel
> 5.18 brought the freezes back. [1]
> 
> 
> My laptop is HP 250 G7 with a Core i3 7020U CPU.
> 
> The RTL8821CE wifi card is in M.2 slot, not soldered to the motherboard,
> even though the interface is named wlo1. It has one antenna, in case
> that matters.
> 
> The router is a Fiberhome HG6544C.
> 
> The network is secured with WPA2 Personal.
> 
> The kernel version is 5.18.5-arch1-1.
> 
> The wifi firmware version is 24.11.0.
> 
> NetworkManager version is 1.38.2-1.
> 
> wpa_supplicant version is 2.10-4.
> 
> The operating system is Arch Linux.
> 
> 
> 
> Just out of curiosity, what is C2H with id 0x15 ? It is not handled by
> rtw88, but the firmware sends it often.
> 
> 
> [0] https://raw.githubusercontent.com/tomaspinho/rtl8821ce/be733dc86781c68571650b395dd0fa6b53c0a039/hal/rtl8821c/hal8821c_fw.c
> [1] https://lore.kernel.org/linux-wireless/Te_PJvJjKCi-lK28Zu0d8VQG0AGdwTl6cJydYEETLbc3gN0l8liXH1DSOZnKxUHYGxavLBCs1sqos2e6jeiRzzO0RLRSISdWvTiiPp0v9kM=@protonmail.com/
> 

A symptom I forgot to mention: rtw88 fills the journal with lots and lots
of CTRL-EVENT-BEACON-LOSS.

I had another look at this problem recently and discovered that disabling
dig and cckpd in the dynamic mechanism "fixes" it. Making them write the
default values instead of what they calculate also works:

diff --git a/phy.c b/phy.c
index 5753462..a4e2cd2 100644
--- a/phy.c
+++ b/phy.c
@@ -241,6 +241,8 @@ void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
 	for (path = 0; path < hal->rf_path_num; path++) {
 		addr = chip->dig[path].addr;
 		mask = chip->dig[path].mask;
+		if (chip->id == RTW_CHIP_TYPE_8821C)
+			igi = 0x20;
 		rtw_write32_mask(rtwdev, addr, mask, igi);
 	}
 }
@@ -746,6 +748,9 @@ static void rtw_phy_cck_pd(struct rtw_dev *rtwdev)
 	if (level >= CCK_PD_LV_MAX)
 		return;
 
+	if (chip->id == RTW_CHIP_TYPE_8821C)
+		level = CCK_PD_LV0;
+
 	if (chip->ops->cck_pd_set)
 		chip->ops->cck_pd_set(rtwdev, level);
 }

I don't understand why this helps. rtw88 calculates more or less the
same initial gain and cckpd level as the vendor driver.

I implemented the DC cancellation in rtw88, hoping it would help. It
didn't.

I found this mistake in the false alarm code. Fixing it didn't help:

diff --git a/rtw8821c.c b/rtw8821c.c
index 7b624ec..e9c6d46 100644
--- a/rtw8821c.c
+++ b/rtw8821c.c
@@ -683,9 +685,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
 	dm_info->cck_fa_cnt = cck_fa_cnt;
 	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
+	dm_info->total_fa_cnt = ofdm_fa_cnt;
 	if (cck_enable)
 		dm_info->total_fa_cnt += cck_fa_cnt;
-	dm_info->total_fa_cnt = ofdm_fa_cnt;
 
 	crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
 	dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);

What else should I check?
