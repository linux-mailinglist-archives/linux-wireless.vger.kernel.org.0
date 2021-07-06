Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5123BDF6C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jul 2021 00:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGFWhE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 18:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFWhE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 18:37:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D3C061574
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jul 2021 15:34:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a18so503045lfs.10
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jul 2021 15:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kgdSSee64DhWpmw/1z/1CTjac6yaE8HcZZdt3bAb+SU=;
        b=S3OO7us35u7LrWCLfaRlkPN7Vnqt5FkfjSdvtJMJK89kaKw3XyVGGwetiZPmV6PM/y
         Gl92tqo3ue3MqHKJXy21mFgbv5e6T4OvtWsXhibXvFzCwTLxcW89EjADsjRVfMjRPz/S
         hQYe8xcjimooV0CVp45AR8QHaHI/HRudzdCgWhTAISWcC2cgNnNtvOd53cGf8EhFOApV
         v4hE22UJ+b8S4ueMLnmvvF98zhheJzMkCgT15Aq/SSAD/eTVjnLf67zcUnjpKYfFwSzj
         RzC9NkWA2CTiDWN9PcdR19HuvpDifIG7BweckmBIaIOUx2qj0RSzcXYZRaytsuw0rheX
         07SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kgdSSee64DhWpmw/1z/1CTjac6yaE8HcZZdt3bAb+SU=;
        b=ey/4sJWplSxsh+mwD3k8TfaqUbjwWdiGZc9tGDwDfoN3wS1Cw02XI8XUY8RAYD72Q4
         zIimqy1yDZyq0n6iJ0HdIifkrPs5rMQri3klhAzHz+SGff8ZowXUpE2gcgz1hbapu6WA
         5K44DjDPXms6Pwh/T19ijKIF3wHofP2AHwMsHpi8MHfCjtuIFNds7aRcFnAf1ekrOvSY
         lqTqGVz13Q53htd2rp+7CMqlsGNSti6P4A1iMHBpoE6vn0LHuACCPNXVpkm7+zSnAZoE
         gBPfrZT/mJijnqveXfho6gJfqg/hKaQbx1nXX72FXVFDDXOG5YyFBGL3KWw6OgF3ZvK/
         cgPQ==
X-Gm-Message-State: AOAM531NIGvavkCDhsYENWyKF1HSsME9UTP7sG0S9eWl1lLH0Pv2tRGW
        P0JYoG9JXTB4CV64GjbFSqA=
X-Google-Smtp-Source: ABdhPJyF0MrJh2cuVWxqEwVZT8mAS5znQXqG5F/j/NCK7xfK87xEawFv3BdurKky7e1rSvEQlaSqnA==
X-Received: by 2002:a19:ad4d:: with SMTP id s13mr313416lfd.432.1625610863227;
        Tue, 06 Jul 2021 15:34:23 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id f19sm1005423lfs.133.2021.07.06.15.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 15:34:22 -0700 (PDT)
Subject: Re: Unstable WiFi with mt76 on MT7628AN
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <7c96d5ee-86c1-8068-1b58-40db6087a24f@gmail.com>
 <2528003d-f45a-a771-e96d-5796035ccdfe@gmail.com>
Message-ID: <e774cda7-761f-7fb1-25b8-fc096617dd77@gmail.com>
Date:   Wed, 7 Jul 2021 00:34:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <2528003d-f45a-a771-e96d-5796035ccdfe@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 04.07.2021 09:36, Rafał Miłecki wrote:
> A small update (no good news).

Felix suggested that EEPROM access may be not setup correctly on my
device.


First, let me provide a dump of the "factory" MTD partition:

# hexdump -n 4096 -C /dev/mtdblock2
00000000  28 76 00 02 9c 9d 7e 58  10 56 00 00 00 00 00 00  |(v....~X.V......|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000020  00 00 00 00 20 00 00 00  9c 9d 7e 58 10 55 00 0c  |.... .....~X.U..|
00000030  43 e1 76 2a 22 34 00 20  ff ff 00 01 00 00 00 00  |C.v*"4. ........|
00000040  00 00 22 00 00 00 00 00  30 00 00 00 00 00 00 00  |..".....0.......|
00000050  80 00 00 94 40 ba c0 ca  16 84 82 82 40 ca 16 83  |....@.......@...|
00000060  83 83 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000000a0  c0 c0 c0 c0 c0 c0 c0 c0  c0 c0 c0 c0 c0 c0 00 00  |................|
000000b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
000000c0  00 00 00 00 00 00 00 00  00 1a 22 2a 31 35 01 35  |.........."*15.5|
000000d0  39 40 46 4d 7f 7f 7f 00  00 00 00 00 00 00 00 00  |9@FM............|
000000e0  11 1d 11 1d 1c 35 1c 35  1e 35 1e 35 17 19 17 19  |.....5.5.5.5....|
000000f0  02 00 00 00 c3 00 c0 00  0a 00 00 00 00 00 00 00  |................|
00000100  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
00000120  00 00 00 00 00 00 00 00  00 00 00 00 00 00 77 00  |..............w.|
00000130  11 1d 11 1d 15 7f 15 7f  17 7f 17 7f 10 3b 10 3b  |.............;.;|
00000140  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
*
00001000


I modified mt7603_eeprom_load to dump EEPROM beginning make sure mt76
access exactly that data. It does:

[   11.188447] [mt7603_eeprom_load] 28 76 00 02 9c 9d 7e 58 10 56 00 00 00 00 00 00
[   11.195950] [mt7603_eeprom_load] ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff


Finally I dumped all known EEPROM entries to let you check them. I think
they don't look all random and may make some sense:

[   11.204332] MT_EE_CHIP_ID:   28 76
[   11.207598] MT_EE_VERSION:   00 02
[   11.210875] MT_EE_MAC_ADDR:  9c 9d 7e 58 10 56
[   11.215284] MT_EE_NIC_CONF_0:        22 34
[   11.218823] MT_EE_NIC_CONF_1:        00 20
[   11.222352] MT_EE_NIC_CONF_2:        22 00
[   11.225881] MT_EE_XTAL_TRIM_1:       00
[   11.229243] MT_EE_RSSI_OFFSET_2G:    00
[   11.232859] MT_EE_WIFI_RF_SETTING:   30
[   11.236564] MT_EE_RSSI_OFFSET_5G:    00
[   11.240191] MT_EE_TX_POWER_DELTA_BW40:       80
[   11.244249] MT_EE_TX_POWER_DELTA_BW80:       00
[   11.248306] MT_EE_TX_POWER_EXT_PA_5G:        40
[   11.252283] MT_EE_TEMP_SENSOR_CAL:   ba
[   11.255988] MT_EE_TX_POWER_0_START_2G:       c0 ca 16 84 82 82
[   11.261375] MT_EE_TX_POWER_1_START_2G:       40 ca 16 83 83 83
[   11.266753] MT_EE_TX_POWER_0_START_5G:       00
[   11.270820] MT_EE_TX_POWER_0_GRP3_TX_POWER_DELTA:    00
[   11.275845] MT_EE_TX_POWER_0_GRP4_TSSI_SLOPE:        00
[   11.280528] MT_EE_TX_POWER_1_START_5G:       00
[   11.284584] MT_EE_TX_POWER_CCK:      c0 c0
[   11.288290] MT_EE_TX_POWER_OFDM_2G_6M:       c0 c0
[   11.292620] MT_EE_TX_POWER_OFDM_2G_24M:      c0 c0
[   11.297030] MT_EE_TX_POWER_OFDM_2G_54M:      c0 c0
[   11.301448] MT_EE_TX_POWER_HT_BPSK_QPSK:     c0 c0
[   11.305946] MT_EE_TX_POWER_HT_16_64_QAM:     c0 c0
[   11.310451] MT_EE_TX_POWER_HT_64_QAM:        c0 c0
[   11.314685] MT_EE_ELAN_RX_MODE_GAIN: 00
[   11.318575] MT_EE_ELAN_RX_MODE_NF:   00
[   11.322281] MT_EE_ELAN_RX_MODE_P1DB: 00
[   11.326162] MT_EE_ELAN_BYPASS_MODE_GAIN:     00
[   11.330404] MT_EE_ELAN_BYPASS_MODE_NF:       00
[   11.334462] MT_EE_ELAN_BYPASS_MODE_P1DB:     00
[   11.338705] MT_EE_STEP_NUM_NEG_6_7:  00 00
[   11.342762] MT_EE_STEP_NUM_NEG_4_5:  00 1a
[   11.346819] MT_EE_STEP_NUM_NEG_2_3:  22 2a
[   11.350885] MT_EE_STEP_NUM_NEG_0_1:  31 35
[   11.354942] MT_EE_REF_STEP_24G:      01 35
[   11.358657] MT_EE_STEP_NUM_PLUS_1_2: 39 40
[   11.362802] MT_EE_STEP_NUM_PLUS_3_4: 46 4d
[   11.366947] MT_EE_STEP_NUM_PLUS_5_6: 7f 7f
[   11.371101] MT_EE_STEP_NUM_PLUS_7:   7f
[   11.374807] MT_EE_CP_FT_VERSION:     02
[   11.378336] MT_EE_TX_POWER_TSSI_OFF: 00
[   11.382231] MT_EE_XTAL_FREQ_OFFSET:  c3
[   11.386025] MT_EE_XTAL_TRIM_2_COMP:  00
[   11.389828] MT_EE_XTAL_TRIM_3_COMP:  c0
[   11.393620] MT_EE_XTAL_WF_RFCAL:     00


My device has OTP but DTS file doesn't include
mediatek,eeprom-merge-otp;

If I decided to add that property it'd result in following changes:
[   11.397156] [mt7603_apply_cal_free_data:121] [055] ba -> ba
[   11.402810] [mt7603_apply_cal_free_data:121] [0f0] 02 -> 02
[   11.408464] [mt7603_apply_cal_free_data:121] [0f4] c3 -> ba
[   11.414109] [mt7603_apply_cal_free_data:121] [0f7] 00 -> 88

So it seems OTP contains different values for MT_EE_XTAL_FREQ_OFFSET and
MT_EE_XTAL_WF_RFCAL.


Any other ideas what may cause this unstable WiFi, how to debug it?


diff --git a/mt7603/eeprom.c b/mt7603/eeprom.c
index d951cb8..cc68085 100644
--- a/mt7603/eeprom.c
+++ b/mt7603/eeprom.c
@@ -118,6 +118,7 @@ mt7603_apply_cal_free_data(struct mt7603_dev *dev, u8 *efuse)
  	for (i = 0; i < n; i++) {
  		int offset = cal_free_bytes[i];

+		pr_info("[%s:%d] [%03x] %02x -> %02x\n", __func__, __LINE__, offset, eeprom[offset], efuse[offset]);
  		eeprom[offset] = efuse[offset];
  	}
  }
@@ -131,6 +132,9 @@ mt7603_eeprom_load(struct mt7603_dev *dev)
  	if (ret < 0)
  		return ret;

+	pr_info("[%s] %*ph\n", __func__, 16, dev->mt76.eeprom.data);
+	pr_info("[%s] %*ph\n", __func__, 16, dev->mt76.eeprom.data + 16);
+
  	return mt7603_efuse_init(dev);
  }

@@ -162,6 +166,56 @@ int mt7603_eeprom_init(struct mt7603_dev *dev)
  	if (ret < 0)
  		return ret;

+	eeprom = (u8 *)dev->mt76.eeprom.data;
+	pr_info("MT_EE_CHIP_ID:\t%*ph\n", 2, &eeprom[MT_EE_CHIP_ID]);
+	pr_info("MT_EE_VERSION:\t%*ph\n", 2, &eeprom[MT_EE_VERSION]);
+	pr_info("MT_EE_MAC_ADDR:\t%*ph\n", 6, &eeprom[MT_EE_MAC_ADDR]);
+	pr_info("MT_EE_NIC_CONF_0:\t%*ph\n", 2, &eeprom[MT_EE_NIC_CONF_0]);
+	pr_info("MT_EE_NIC_CONF_1:\t%*ph\n", 2, &eeprom[MT_EE_NIC_CONF_1]);
+	pr_info("MT_EE_NIC_CONF_2:\t%*ph\n", 2, &eeprom[MT_EE_NIC_CONF_2]);
+	pr_info("MT_EE_XTAL_TRIM_1:\t%*ph\n", 1, &eeprom[MT_EE_XTAL_TRIM_1]);
+	pr_info("MT_EE_RSSI_OFFSET_2G:\t%*ph\n", 1, &eeprom[MT_EE_RSSI_OFFSET_2G]);
+	pr_info("MT_EE_WIFI_RF_SETTING:\t%*ph\n", 1, &eeprom[MT_EE_WIFI_RF_SETTING]);
+	pr_info("MT_EE_RSSI_OFFSET_5G:\t%*ph\n", 1, &eeprom[MT_EE_RSSI_OFFSET_5G]);
+	pr_info("MT_EE_TX_POWER_DELTA_BW40:\t%*ph\n", 1, &eeprom[MT_EE_TX_POWER_DELTA_BW40]);
+	pr_info("MT_EE_TX_POWER_DELTA_BW80:\t%*ph\n", 1, &eeprom[MT_EE_TX_POWER_DELTA_BW80]);
+	pr_info("MT_EE_TX_POWER_EXT_PA_5G:\t%*ph\n", 1, &eeprom[MT_EE_TX_POWER_EXT_PA_5G]);
+	pr_info("MT_EE_TEMP_SENSOR_CAL:\t%*ph\n", 1, &eeprom[MT_EE_TEMP_SENSOR_CAL]);
+	pr_info("MT_EE_TX_POWER_0_START_2G:\t%*ph\n", 6, &eeprom[MT_EE_TX_POWER_0_START_2G]);
+	pr_info("MT_EE_TX_POWER_1_START_2G:\t%*ph\n", 6, &eeprom[MT_EE_TX_POWER_1_START_2G]);
+	pr_info("MT_EE_TX_POWER_0_START_5G:\t%*ph\n", 1, &eeprom[MT_EE_TX_POWER_0_START_5G]);
+	pr_info("MT_EE_TX_POWER_0_GRP3_TX_POWER_DELTA:\t%*ph\n", 1, &eeprom[MT_EE_TX_POWER_0_GRP3_TX_POWER_DELTA]);
+	pr_info("MT_EE_TX_POWER_0_GRP4_TSSI_SLOPE:\t%*ph\n", 1, &eeprom[MT_EE_TX_POWER_0_GRP4_TSSI_SLOPE]);
+	pr_info("MT_EE_TX_POWER_1_START_5G:\t%*ph\n", 1, &eeprom[MT_EE_TX_POWER_1_START_5G]);
+	pr_info("MT_EE_TX_POWER_CCK:\t%*ph\n", 2, &eeprom[MT_EE_TX_POWER_CCK]);
+	pr_info("MT_EE_TX_POWER_OFDM_2G_6M:\t%*ph\n", 2, &eeprom[MT_EE_TX_POWER_OFDM_2G_6M]);
+	pr_info("MT_EE_TX_POWER_OFDM_2G_24M:\t%*ph\n", 2, &eeprom[MT_EE_TX_POWER_OFDM_2G_24M]);
+	pr_info("MT_EE_TX_POWER_OFDM_2G_54M:\t%*ph\n", 2, &eeprom[MT_EE_TX_POWER_OFDM_2G_54M]);
+	pr_info("MT_EE_TX_POWER_HT_BPSK_QPSK:\t%*ph\n", 2, &eeprom[MT_EE_TX_POWER_HT_BPSK_QPSK]);
+	pr_info("MT_EE_TX_POWER_HT_16_64_QAM:\t%*ph\n", 2, &eeprom[MT_EE_TX_POWER_HT_16_64_QAM]);
+	pr_info("MT_EE_TX_POWER_HT_64_QAM:\t%*ph\n", 2, &eeprom[MT_EE_TX_POWER_HT_64_QAM]);
+	pr_info("MT_EE_ELAN_RX_MODE_GAIN:\t%*ph\n", 1, &eeprom[MT_EE_ELAN_RX_MODE_GAIN]);
+	pr_info("MT_EE_ELAN_RX_MODE_NF:\t%*ph\n", 1, &eeprom[MT_EE_ELAN_RX_MODE_NF]);
+	pr_info("MT_EE_ELAN_RX_MODE_P1DB:\t%*ph\n", 1, &eeprom[MT_EE_ELAN_RX_MODE_P1DB]);
+	pr_info("MT_EE_ELAN_BYPASS_MODE_GAIN:\t%*ph\n", 1, &eeprom[MT_EE_ELAN_BYPASS_MODE_GAIN]);
+	pr_info("MT_EE_ELAN_BYPASS_MODE_NF:\t%*ph\n", 1, &eeprom[MT_EE_ELAN_BYPASS_MODE_NF]);
+	pr_info("MT_EE_ELAN_BYPASS_MODE_P1DB:\t%*ph\n", 1, &eeprom[MT_EE_ELAN_BYPASS_MODE_P1DB]);
+	pr_info("MT_EE_STEP_NUM_NEG_6_7:\t%*ph\n", 2, &eeprom[MT_EE_STEP_NUM_NEG_6_7]);
+	pr_info("MT_EE_STEP_NUM_NEG_4_5:\t%*ph\n", 2, &eeprom[MT_EE_STEP_NUM_NEG_4_5]);
+	pr_info("MT_EE_STEP_NUM_NEG_2_3:\t%*ph\n", 2, &eeprom[MT_EE_STEP_NUM_NEG_2_3]);
+	pr_info("MT_EE_STEP_NUM_NEG_0_1:\t%*ph\n", 2, &eeprom[MT_EE_STEP_NUM_NEG_0_1]);
+	pr_info("MT_EE_REF_STEP_24G:\t%*ph\n", 2, &eeprom[MT_EE_REF_STEP_24G]);
+	pr_info("MT_EE_STEP_NUM_PLUS_1_2:\t%*ph\n", 2, &eeprom[MT_EE_STEP_NUM_PLUS_1_2]);
+	pr_info("MT_EE_STEP_NUM_PLUS_3_4:\t%*ph\n", 2, &eeprom[MT_EE_STEP_NUM_PLUS_3_4]);
+	pr_info("MT_EE_STEP_NUM_PLUS_5_6:\t%*ph\n", 2, &eeprom[MT_EE_STEP_NUM_PLUS_5_6]);
+	pr_info("MT_EE_STEP_NUM_PLUS_7:\t%*ph\n", 1, &eeprom[MT_EE_STEP_NUM_PLUS_7]);
+	pr_info("MT_EE_CP_FT_VERSION:\t%*ph\n", 1, &eeprom[MT_EE_CP_FT_VERSION]);
+	pr_info("MT_EE_TX_POWER_TSSI_OFF:\t%*ph\n", 1, &eeprom[MT_EE_TX_POWER_TSSI_OFF]);
+	pr_info("MT_EE_XTAL_FREQ_OFFSET:\t%*ph\n", 1, &eeprom[MT_EE_XTAL_FREQ_OFFSET]);
+	pr_info("MT_EE_XTAL_TRIM_2_COMP:\t%*ph\n", 1, &eeprom[MT_EE_XTAL_TRIM_2_COMP]);
+	pr_info("MT_EE_XTAL_TRIM_3_COMP:\t%*ph\n", 1, &eeprom[MT_EE_XTAL_TRIM_3_COMP]);
+	pr_info("MT_EE_XTAL_WF_RFCAL:\t%*ph\n", 1, &eeprom[MT_EE_XTAL_WF_RFCAL]);
+
  	if (dev->mt76.otp.data) {
  		if (mt7603_check_eeprom(&dev->mt76) == 0)
  			mt7603_apply_cal_free_data(dev, dev->mt76.otp.data);
