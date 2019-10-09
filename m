Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D97CD16E9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 19:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbfJIRhd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 13:37:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34649 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbfJIRhc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 13:37:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id 83so2499372oii.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2019 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mErt0745RVOs01oDGmR3+8x4Bbjk08I6HvvIQ+lPkf4=;
        b=oaIZ3fhnA+w1tiPYVsA5L2ksTPs7Nx4XxKssNgSv03tITXAZcRrCLIU0jQsgpzQ4DF
         mC4VbgekdaPd/jAjs8ZfgtAjA+zFaHiLgkWv4asIf+opU21mUxMZ1MsnqP05KS11LPTS
         DS04z3eiuj8nrAQjW8qonFPcMOCW4pWaxWWrVbyNlQ3RkAsePoaF+QYFqVbooFzRU/QI
         0XwuZw5vEpmz+BUO5N3/adIA8QkM9TXGx463Ih47FHkBzda8nvvxXk9/wPpI3XnXjfP9
         fEQD8gyFrdglF5VVb7rtwaicUU7DWESy3JJ7u0NqSspMZOmvzyffr/XuU/kLabB4vr9a
         INWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mErt0745RVOs01oDGmR3+8x4Bbjk08I6HvvIQ+lPkf4=;
        b=eJoiGEPZsFQYafOAPcNh5PuEUzCKFHceJgV+XXxeByO9Ud2xqc/MBHz4aVDUR6f3Ru
         H008s5rAibwCzoYaXwsZ31U6fvfm5iv9ngZ1nxVWL0rAizcJD8TejCff7Nwk+VerEy1J
         btFSIXQgeVSO+NXQgta24w0eG2Pw4TB7Uh54otTHwLosoYjSYzQ6zd69Ax157i2L8QGu
         6T4JVK9l9ta75d1Y4ZYOcaa7+O4Z0TwfsJ+LwR3tgoyK8dR0eszyAohDJ3XR20Io532b
         XItLi59r2gsVER5SyEm1Tz6XDAUJvXyIIX0q7D4Rfv+FbXoiWp1rk5JAHgtMoCYmNwI8
         qxig==
X-Gm-Message-State: APjAAAU1DfiMmxMKqNFJqCx0zNjom6mBtMfQcVlvgQeioj++OTaIgkFC
        Sd4Ffxb6OTSTvc+gB61DtRA=
X-Google-Smtp-Source: APXvYqypkagTyBIulHyizoSh5sXUxUPaecTKp8sxwgBqxZv8xgCsadYIl12JelkgQTW/86+heW3L1w==
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr3580366oic.98.1570642651038;
        Wed, 09 Oct 2019 10:37:31 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s66sm848199otb.65.2019.10.09.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:37:30 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4/4] rtlwifi: rtl8192se: Convert inline routines to little-endian words
Date:   Wed,  9 Oct 2019 12:37:11 -0500
Message-Id: <20191009173711.20348-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009173711.20348-1-Larry.Finger@lwfinger.net>
References: <20191009173711.20348-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In this step, the read/write routines for the descriptors are converted
to use __le32 quantities, thus a lot of casts can be removed. Callback
routines still use the 8-bit arrays, but these are changed within the
specified routine.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8192se/def.h  | 216 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8192se/trx.c  |  24 +-
 2 files changed, 122 insertions(+), 118 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
index 09baa74709ea..f43331224851 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
@@ -27,182 +27,182 @@
 /* macros to read/write various fields in RX or TX descriptors */
 
 /* Dword 0 */
-static inline void set_tx_desc_pkt_size(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(15, 0));
 }
 
-static inline void set_tx_desc_offset(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_offset(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16));
+	le32p_replace_bits(__pdesc, __val, GENMASK(23, 16));
 }
 
-static inline void set_tx_desc_last_seg(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_last_seg(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26));
+	le32p_replace_bits(__pdesc, __val, BIT(26));
 }
 
-static inline void set_tx_desc_first_seg(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_first_seg(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27));
+	le32p_replace_bits(__pdesc, __val, BIT(27));
 }
 
-static inline void set_tx_desc_linip(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_linip(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28));
+	le32p_replace_bits(__pdesc, __val, BIT(28));
 }
 
-static inline void set_tx_desc_own(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_own(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+	le32p_replace_bits(__pdesc, __val, BIT(31));
 }
 
-static inline u32 get_tx_desc_own(u8 *__pdesc)
+static inline u32 get_tx_desc_own(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(31));
+	return le32_get_bits(*(__pdesc), BIT(31));
 }
 
 /* Dword 1 */
-static inline void set_tx_desc_macid(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_macid(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(4, 0));
 }
 
-static inline void set_tx_desc_queue_sel(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_queue_sel(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(12, 8));
 }
 
-static inline void set_tx_desc_non_qos(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_non_qos(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(16));
+	le32p_replace_bits((__pdesc + 1), __val, BIT(16));
 }
 
-static inline void set_tx_desc_sec_type(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_sec_type(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
+	le32p_replace_bits((__pdesc + 1), __val, GENMASK(23, 22));
 }
 
 /* Dword 2 */
-static inline void	set_tx_desc_rsvd_macid(u8 *__pdesc, u32 __val)
+static inline void	set_tx_desc_rsvd_macid(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(28, 24));
+	le32p_replace_bits((__pdesc + 2), __val, GENMASK(28, 24));
 }
 
-static inline void set_tx_desc_agg_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_agg_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(29));
+	le32p_replace_bits((__pdesc + 2), __val, BIT(29));
 }
 
 /* Dword 3 */
-static inline void set_tx_desc_seq(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_seq(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16));
+	le32p_replace_bits((__pdesc + 3), __val, GENMASK(27, 16));
 }
 
 /* Dword 4 */
-static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(5, 0));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(5, 0));
 }
 
-static inline void set_tx_desc_cts_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_cts_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(11));
 }
 
-static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_enable(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(12));
 }
 
-static inline void set_tx_desc_ra_brsr_id(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_ra_brsr_id(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(15, 13));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(15, 13));
 }
 
-static inline void set_tx_desc_txht(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_txht(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(16));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(16));
 }
 
-static inline void set_tx_desc_tx_short(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_short(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(17));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(17));
 }
 
-static inline void set_tx_desc_tx_bandwidth(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_bandwidth(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(18));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(18));
 }
 
-static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_sub_carrier(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(20, 19));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(20, 19));
 }
 
-static inline void set_tx_desc_rts_short(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_short(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(25));
 }
 
-static inline void set_tx_desc_rts_bandwidth(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_bandwidth(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(26));
 }
 
-static inline void set_tx_desc_rts_sub_carrier(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_sub_carrier(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(28, 27));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(28, 27));
 }
 
-static inline void set_tx_desc_rts_stbc(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_rts_stbc(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(30, 29));
+	le32p_replace_bits((__pdesc + 4), __val, GENMASK(30, 29));
 }
 
-static inline void set_tx_desc_user_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_user_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(31));
+	le32p_replace_bits((__pdesc + 4), __val, BIT(31));
 }
 
 /* Dword 5 */
-static inline void set_tx_desc_packet_id(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_packet_id(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(8, 0));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(8, 0));
 }
 
-static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_rate(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(14, 9));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(14, 9));
 }
 
-static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_data_rate_fb_limit(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(20, 16));
+	le32p_replace_bits((__pdesc + 5), __val, GENMASK(20, 16));
 }
 
 /* Dword 7 */
-static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_size(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+	le32p_replace_bits((__pdesc + 7), __val, GENMASK(15, 0));
 }
 
 /* Dword 8 */
-static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val);
+	*(__pdesc + 8) = cpu_to_le32(__val);
 }
 
-static inline u32 get_tx_desc_tx_buffer_address(u8 *__pdesc)
+static inline u32 get_tx_desc_tx_buffer_address(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 32)));
+	return le32_to_cpu(*((__pdesc + 8)));
 }
 
 /* Dword 9 */
-static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
+static inline void set_tx_desc_next_desc_address(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 36) = cpu_to_le32(__val);
+	*(__pdesc + 9) = cpu_to_le32(__val);
 }
 
 /* Because the PCI Tx descriptors are chaied at the
@@ -220,108 +220,108 @@ static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
 #define RX_DRV_INFO_SIZE_UNIT				8
 
 /* DWORD 0 */
-static inline void set_rx_status_desc_pkt_len(u8 *__pdesc, u32 __val)
+static inline void set_rx_status_desc_pkt_len(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0));
+	le32p_replace_bits(__pdesc, __val, GENMASK(13, 0));
 }
 
-static inline void set_rx_status_desc_eor(u8 *__pdesc, u32 __val)
+static inline void set_rx_status_desc_eor(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30));
+	le32p_replace_bits(__pdesc, __val, BIT(30));
 }
 
-static inline void set_rx_status_desc_own(u8 *__pdesc, u32 __val)
+static inline void set_rx_status_desc_own(__le32 *__pdesc, u32 __val)
 {
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+	le32p_replace_bits(__pdesc, __val, BIT(31));
 }
 
-static inline u32 get_rx_status_desc_pkt_len(u8 *__pdesc)
+static inline u32 get_rx_status_desc_pkt_len(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(13, 0));
+	return le32_get_bits(*(__pdesc), GENMASK(13, 0));
 }
 
-static inline u32 get_rx_status_desc_crc32(u8 *__pdesc)
+static inline u32 get_rx_status_desc_crc32(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(14));
+	return le32_get_bits(*(__pdesc), BIT(14));
 }
 
-static inline u32 get_rx_status_desc_icv(u8 *__pdesc)
+static inline u32 get_rx_status_desc_icv(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(15));
+	return le32_get_bits(*(__pdesc), BIT(15));
 }
 
-static inline u32 get_rx_status_desc_drvinfo_size(u8 *__pdesc)
+static inline u32 get_rx_status_desc_drvinfo_size(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(19, 16));
+	return le32_get_bits(*(__pdesc), GENMASK(19, 16));
 }
 
-static inline u32 get_rx_status_desc_shift(u8 *__pdesc)
+static inline u32 get_rx_status_desc_shift(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(25, 24));
+	return le32_get_bits(*(__pdesc), GENMASK(25, 24));
 }
 
-static inline u32 get_rx_status_desc_phy_status(u8 *__pdesc)
+static inline u32 get_rx_status_desc_phy_status(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(26));
+	return le32_get_bits(*(__pdesc), BIT(26));
 }
 
-static inline u32 get_rx_status_desc_swdec(u8 *__pdesc)
+static inline u32 get_rx_status_desc_swdec(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(27));
+	return le32_get_bits(*(__pdesc), BIT(27));
 }
 
-static inline u32 get_rx_status_desc_own(u8 *__pdesc)
+static inline u32 get_rx_status_desc_own(__le32 *__pdesc)
 {
-	return le32_get_bits(*((__le32 *)__pdesc), BIT(31));
+	return le32_get_bits(*(__pdesc), BIT(31));
 }
 
 /* DWORD 1 */
-static inline u32 get_rx_status_desc_paggr(u8 *__pdesc)
+static inline u32 get_rx_status_desc_paggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14));
+	return le32_get_bits(*(__pdesc + 1), BIT(14));
 }
 
-static inline u32 get_rx_status_desc_faggr(u8 *__pdesc)
+static inline u32 get_rx_status_desc_faggr(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15));
+	return le32_get_bits(*(__pdesc + 1), BIT(15));
 }
 
 /* DWORD 3 */
-static inline u32 get_rx_status_desc_rx_mcs(u8 *__pdesc)
+static inline u32 get_rx_status_desc_rx_mcs(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0));
+	return le32_get_bits(*(__pdesc + 3), GENMASK(5, 0));
 }
 
-static inline u32 get_rx_status_desc_rx_ht(u8 *__pdesc)
+static inline u32 get_rx_status_desc_rx_ht(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6));
+	return le32_get_bits(*(__pdesc + 3), BIT(6));
 }
 
-static inline u32 get_rx_status_desc_splcp(u8 *__pdesc)
+static inline u32 get_rx_status_desc_splcp(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8));
+	return le32_get_bits(*(__pdesc + 3), BIT(8));
 }
 
-static inline u32 get_rx_status_desc_bw(u8 *__pdesc)
+static inline u32 get_rx_status_desc_bw(__le32 *__pdesc)
 {
-	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9));
+	return le32_get_bits(*(__pdesc + 3), BIT(9));
 }
 
 /* DWORD 5 */
-static inline u32 get_rx_status_desc_tsfl(u8 *__pdesc)
+static inline u32 get_rx_status_desc_tsfl(__le32 *__pdesc)
 {
-	return le32_to_cpu(*((__le32 *)(__pdesc + 20)));
+	return le32_to_cpu(*((__pdesc + 5)));
 }
 
 /* DWORD 6 */
-static inline void set_rx_status__desc_buff_addr(u8 *__pdesc, u32 __val)
+static inline void set_rx_status__desc_buff_addr(__le32 *__pdesc, u32 __val)
 {
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+	*(__pdesc + 6) = cpu_to_le32(__val);
 }
 
-static inline u32 get_rx_status_desc_buff_addr(u8 *__pdesc)
+static inline u32 get_rx_status_desc_buff_addr(__le32 *__pdesc)
 {
-	return le32_to_cpu(*(__le32 *)(__pdesc + 24));
+	return le32_to_cpu(*(__pdesc + 6));
 }
 
 #define SE_RX_HAL_IS_CCK_RATE(_pdesc)\
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
index 911bca8233e6..9eaa5348b556 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
@@ -33,7 +33,7 @@ static u8 _rtl92se_map_hwqueue_to_fwqueue(struct sk_buff *skb,	u8 skb_queue)
 }
 
 static void _rtl92se_query_rxphystatus(struct ieee80211_hw *hw,
-				       struct rtl_stats *pstats, u8 *pdesc,
+				       struct rtl_stats *pstats, __le32 *pdesc,
 				       struct rx_fwinfo *p_drvinfo,
 				       bool packet_match_bssid,
 				       bool packet_toself,
@@ -193,11 +193,10 @@ static void _rtl92se_query_rxphystatus(struct ieee80211_hw *hw,
 
 static void _rtl92se_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 		struct sk_buff *skb, struct rtl_stats *pstats,
-		u8 *pdesc, struct rx_fwinfo *p_drvinfo)
+		__le32 *pdesc, struct rx_fwinfo *p_drvinfo)
 {
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-
 	struct ieee80211_hdr *hdr;
 	u8 *tmp_buf;
 	u8 *praddr;
@@ -232,10 +231,11 @@ static void _rtl92se_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 }
 
 bool rtl92se_rx_query_desc(struct ieee80211_hw *hw, struct rtl_stats *stats,
-			   struct ieee80211_rx_status *rx_status, u8 *pdesc,
+			   struct ieee80211_rx_status *rx_status, u8 *pdesc8,
 			   struct sk_buff *skb)
 {
 	struct rx_fwinfo *p_drvinfo;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u32 phystatus = (u32)get_rx_status_desc_phy_status(pdesc);
 	struct ieee80211_hdr *hdr;
 
@@ -310,7 +310,7 @@ bool rtl92se_rx_query_desc(struct ieee80211_hw *hw, struct rtl_stats *stats,
 }
 
 void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
-		struct ieee80211_hdr *hdr, u8 *pdesc_tx,
+		struct ieee80211_hdr *hdr, u8 *pdesc8,
 		u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
 		struct ieee80211_sta *sta,
 		struct sk_buff *skb,
@@ -320,7 +320,7 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	u8 *pdesc = pdesc_tx;
+	__le32 *pdesc = (__le32 *)pdesc8;
 	u16 seq_number;
 	__le16 fc = hdr->frame_control;
 	u8 reserved_macid = 0;
@@ -491,13 +491,14 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
-void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
-	bool firstseg, bool lastseg, struct sk_buff *skb)
+void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
+			     bool firstseg, bool lastseg, struct sk_buff *skb)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_tcb_desc *tcb_desc = (struct rtl_tcb_desc *)(skb->cb);
+	__le32 *pdesc = (__le32 *)pdesc8;
 
 	dma_addr_t mapping = pci_map_single(rtlpci->pdev, skb->data, skb->len,
 			PCI_DMA_TODEVICE);
@@ -549,9 +550,11 @@ void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
 	}
 }
 
-void rtl92se_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
+void rtl92se_set_desc(struct ieee80211_hw *hw, u8 *pdesc8, bool istx,
 		      u8 desc_name, u8 *val)
 {
+	__le32 *pdesc = (__le32 *)pdesc8;
+
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
@@ -590,9 +593,10 @@ void rtl92se_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 }
 
 u64 rtl92se_get_desc(struct ieee80211_hw *hw,
-		     u8 *desc, bool istx, u8 desc_name)
+		     u8 *desc8, bool istx, u8 desc_name)
 {
 	u32 ret = 0;
+	__le32 *desc = (__le32 *)desc8;
 
 	if (istx) {
 		switch (desc_name) {
-- 
2.23.0

