Return-Path: <linux-wireless+bounces-28465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC51C2864A
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7666B4E043D
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9712FFDEA;
	Sat,  1 Nov 2025 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb7paD5k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F6275AEB
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025206; cv=none; b=EvyNJMkv+P6WSvMNRnhpeuPPhEbqYh3YYFjs1nINJEgtDEz4vtqDLv1s5LKoyz46sA8MQu333hgKGLHYgXapHyKHTabkxS/4cf6Gthz7SKTv+rjP4/OfE9kG9XxcgLhWNzgFOiCrqnCbki+Q2rB6uq2my0KnLslLctXkWaltqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025206; c=relaxed/simple;
	bh=/pO5bnCuzRVol0g0eG1hXcYQCSPW5AELJ9bPRUaT80c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GT/Qy/6n3+nZsjbuqzFznZvREf88oQUdIjeV8D8NAQrdLUbCTMipU6/cUGrE3Y7tQNmwel7nCof44ty9aPPXxN9I0Unnyc0OclgCM0t5j8CFytMDj5JtR361ca56dMgSC7Gj5+ROia6C5IYV8+hmeZGIzxKsH/CNT0SgMHhyEPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb7paD5k; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so1810760f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762025203; x=1762630003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u9nj1g3ZQYHIfmnEfmWbMq3Nd9J9f5XW8Ln4eZglRLg=;
        b=Sb7paD5ksSJ1Oa1AIqOooanbSsY7KTQ8godD0VqLmIa8PxoatXtTO1/tPN3tBAsbCp
         JMY67HNFcz8Pjjq5NsQnurT04Ucc1dQ2fi5rMYF4VyybngaMiBaSicY1YW6o1g8ujZKo
         Mmd9syiQVp81OKST1BwCPwaC5aOKbvMII1h9oeB7b3A8v+ypHHbSx1apbyUBSI94r5sQ
         3TYx9qR7komH+ivSxpi+jaCUFVq4q4lXl5AlicEz/pDUQZ/1Wxp0YFhrLJ7vspA2/+f+
         aJbbgNqNosJEpN+ZAx3extlSAYaJykQTBZqeGdHG3Lc59+M67o7l3jN8pvSkSPoRmfyw
         eMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762025203; x=1762630003;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9nj1g3ZQYHIfmnEfmWbMq3Nd9J9f5XW8Ln4eZglRLg=;
        b=F0hH5KETLHbZ9DwMvBUXt0FK9cVFfWm1M7HtMGtidDgyK7kN+ZA96bojXdPOn+QD/r
         hb1vqtPD07qID24I34aXcobj00FQ7a6R6MBr5aS7t5LEPuML17DHDnP8rCmRbj+5yWQH
         UJzIl0/1qWyMtTpEJkUJzT4ncgPwZHVs4TV3u5YTpFrFCaid8+356CcEuwxJcdDUT8te
         PpBb3Od7MXoB+pJz3CB9N12RsWnu89V+7IRbpqMzQ2AwV2yFDINT1nM3mm0GMsyRi2Vw
         gomMZ79dac9xG2p/elsZWBFY9NUw0O0r2+hgVQaN7sXPRJ9mUxvAEgoaWfBDCNj9h64x
         +tkw==
X-Gm-Message-State: AOJu0YwXvr2eYNVz+5DbVj4hb0s4vPocvcuQT8i/FgO+V2MwO2AsLqLP
	Wjwm39igPRZwxtvvri/mDCD29jQZG7hmaO7B5mt51KEcZuvAfRxT/btueWeFFA==
X-Gm-Gg: ASbGnculecp+GvWcua/7rLCwvFdK0mk0rYR4Pj62vpAJ1epmkpYHjB74zk342Aea5g4
	DYWik3iC0HnbCgMhLfOcK5UtVAKe3q6+5jGl8xihdLcdbh+n9nAqoV6o5AJhJp93QdMKlCLsT0G
	+RnLDsZE863kyrvGKV7l/paX1wl63ea8F/wDXajCLwspWOg/7ldBeqbc+Z+maLAdfWEVfIRDXCx
	UXyuPBltg15GF1W8jeEBqbLJTlY4v/YOOgChV8qOzLDVY7NAsO36o4uZNJfOURwGOxIt88QQqgT
	YZaI77Szg8OClu7ZizyAhPHs35xwJrlFBfHpcuy/pfCl/nwhAUKfV17JyT7J+SZKYIr9hrtUZnH
	E+72vhGWpBO9HytaVNcIAnEQ0sfVh3fjUcEQQXmyOFfObqwXQo+wq1exyVC2GK+80iTm7UD/s/1
	k6OUE+1kDD4sln4A5EEm0=
X-Google-Smtp-Source: AGHT+IECI8DFUsXlhFcWJH0+36O/TNpVfMNd/ao23meFClgsf7hCaReUi7I8gfuWadUYAU0FqMUK7Q==
X-Received: by 2002:a5d:5c89:0:b0:429:978f:16ef with SMTP id ffacd0b85a97d-429bd69d7a5mr5715089f8f.30.1762025203413;
        Sat, 01 Nov 2025 12:26:43 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c10ff1besm10416265f8f.9.2025.11.01.12.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:26:43 -0700 (PDT)
Message-ID: <5b90204c-60ad-4579-b241-b7ac2e1fee91@gmail.com>
Date: Sat, 1 Nov 2025 21:26:41 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 09/12] wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

"hfc" means "hci fc" which is "Host Control Interface Flow Control".
These are some parameters needed for RTL8852CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.

v4:
 - Change WP CH 0-11 pre-cost from 48 to 146, as recommended by the
   experts, to fix one of the two problems causing disconnection.
 - Remove Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 46 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 651ef96d143a..10e3963b692c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -51,6 +51,48 @@ static const struct rtw89_hfc_param_ini rtw8852c_hfc_param_ini_pcie[] = {
 	[RTW89_QTA_INVALID] = {NULL},
 };
 
+static const struct rtw89_hfc_ch_cfg rtw8852c_hfc_chcfg_usb[] = {
+	{18, 344, grp_0}, /* ACH 0 */
+	{0, 0, grp_0}, /* ACH 1 */
+	{18, 344, grp_0}, /* ACH 2 */
+	{0, 0, grp_0}, /* ACH 3 */
+	{18, 344, grp_0}, /* ACH 4 */
+	{0, 0, grp_0}, /* ACH 5 */
+	{18, 344, grp_0}, /* ACH 6 */
+	{0, 0, grp_0}, /* ACH 7 */
+	{18, 344, grp_0}, /* B0MGQ */
+	{0, 0, grp_0}, /* B0HIQ */
+	{18, 344, grp_0}, /* B1MGQ */
+	{0, 0, grp_0}, /* B1HIQ */
+	{0, 0, 0} /* FWCMDQ */
+};
+
+static const struct rtw89_hfc_pub_cfg rtw8852c_hfc_pubcfg_usb = {
+	344, /* Group 0 */
+	0, /* Group 1 */
+	344, /* Public Max */
+	0 /* WP threshold */
+};
+
+static const struct rtw89_hfc_prec_cfg rtw8852c_hfc_preccfg_usb = {
+	9, /* CH 0-11 pre-cost */
+	32, /* H2C pre-cost */
+	146, /* WP CH 0-7 pre-cost */
+	146, /* WP CH 8-11 pre-cost */
+	1, /* CH 0-11 full condition */
+	1, /* H2C full condition */
+	1, /* WP CH 0-7 full condition */
+	1, /* WP CH 8-11 full condition */
+};
+
+static const struct rtw89_hfc_param_ini rtw8852c_hfc_param_ini_usb[] = {
+	[RTW89_QTA_SCC] = {rtw8852c_hfc_chcfg_usb, &rtw8852c_hfc_pubcfg_usb,
+			   &rtw8852c_hfc_preccfg_usb, RTW89_HCIFC_STF},
+	[RTW89_QTA_DLFW] = {NULL, NULL,
+			    &rtw8852c_hfc_preccfg_usb, RTW89_HCIFC_STF},
+	[RTW89_QTA_INVALID] = {NULL},
+};
+
 static const struct rtw89_dle_mem rtw8852c_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size19,
 			   &rtw89_mac_size.ple_size19, &rtw89_mac_size.wde_qt18,
@@ -3051,7 +3093,9 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.max_amsdu_limit	= 8000,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= {rtw8852c_hfc_param_ini_pcie, NULL, NULL},
+	.hfc_param_ini		= {rtw8852c_hfc_param_ini_pcie,
+				   rtw8852c_hfc_param_ini_usb,
+				   NULL},
 	.dle_mem		= {rtw8852c_dle_mem_pcie,
 				   rtw8852c_dle_mem_usb2,
 				   rtw8852c_dle_mem_usb3,
-- 
2.51.1


