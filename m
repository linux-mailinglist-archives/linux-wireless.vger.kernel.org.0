Return-Path: <linux-wireless+bounces-28696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA8FC433B4
	for <lists+linux-wireless@lfdr.de>; Sat, 08 Nov 2025 20:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F82188C27A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Nov 2025 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C828489E;
	Sat,  8 Nov 2025 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReCd8eIU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD282701CB
	for <linux-wireless@vger.kernel.org>; Sat,  8 Nov 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762629811; cv=none; b=Y1i1LkBTvzmbJit3xM3A+FdQmg4q3juMOOYbNbTQPmlAYdHi9/ZBG4HQVKrWKHAS73NKf8qwBc/ILiJ2hIkEsJIzJUDcdaWdbWO5zmd7z53B4cfAjWoBZkopqLu+BJFLx3G/sDhlujNHVjCudGkq5E9E9So28xUa9LEnNUmCaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762629811; c=relaxed/simple;
	bh=cRPmFCYdxTzD1ekln8133d96OJkh2HDE2ST5cDKPpC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcCaGRMaRvL7xnWveG5RkosWbx1wPLUPzsW6gbkThh4Qk7p0CIwg3PZJ+1nx38QNIgOU9Ud8kiqRpEOQFENIkEqJkep5xnyFktl1wLx0h4QazpJK8MY6MR4Zoytc7nH/ZQZBPvz7AGlLQnI0IrTOyVRh9M40Op8bwb/l12RnBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReCd8eIU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so2835759a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 08 Nov 2025 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762629808; x=1763234608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjjKiySQ6TC8ivqB+ybHXo1TvvTt6y7RBNqW9pQTM/k=;
        b=ReCd8eIU9dxtngOmPt0BNbGtREIHtnBFd6VzD8ACRjLzrf3EaVVcdrGn6U7TSATQ3v
         M7Ciz/nLyhDKaXqW64LMIBxAxR1nQXS1hCB5lARGgKwj+46OpNM+LWIyHRWYlId/cHxv
         69uKUMEKB217186nzcepBTA1wy7+K5VUvjjP5tgwWqNK6HS6vBOnXtv8bvdKyDOm0u2W
         FR7Nmy+MEekeE9EF3pA+T7a3A4HZduqt2xRBYoo8YP0Hzu7FIe6tCP9EqeQHgWAxFFga
         5n1DV9VVITtZgAsyhvzT7/Tp7mD8Obv+plv/zO/Slbe0qFXBWOZQaw4bpXQSfVFWbnYZ
         Nfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762629808; x=1763234608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gjjKiySQ6TC8ivqB+ybHXo1TvvTt6y7RBNqW9pQTM/k=;
        b=c+IR5fsak7dZ4bTYXryWu9MtUyfYChzL+quAia3vesj24gH50dYgBc5VtO5Q47Rb1a
         e8dadNB4V6gXBxDjk7k5JlpbWVIOJAB+9C2fSkRyMf/j+tYCtGiF9elJs4uZZJoEeiw7
         rBqmR5h5LOB6KO1WGGcnexxJaNSHAU0B3C3u0CHuhUl3nT/N1y2Kg/Ne9959rE5A4H93
         zzXygl8Z0meK5KzKwoLHwieCc+a1EKgrIDWhAzubL0jigZ8GTRfZxu0JtrO9WZxDMLJK
         TcMYvbQDCtaSX0A6tDnojga0HOOZo+E2f2pXwlDhxOFiZzAt2y8fD5yANES4Yi9vp38Z
         7sxw==
X-Gm-Message-State: AOJu0YzlsJeDHGlHXvwYa8IN61FVjCZeoNXJqbHgRjkBI77Ge4hypbu8
	tBboIeSEKD5vIhA90N4PHIzUyyVCW7tuhySx13OcdaOZ4GMVjzcfY/d8xiKO9g==
X-Gm-Gg: ASbGncvXGkvSebIGWLb5w3dWwOitDqrc23la6/u3m//RTVa9laPuGgMX3LSANB3a6MT
	/S7vERp5mcyfJW4ygPbldedqdKUYld6W3dn0FpeFExflLV301IZBjW1rH3GNN9zcgqIWaI93P4R
	ppZtcdnpNNBOVFMaz8xTkQexRhqZgJednr2qtWao4+hmPc+YmiyP9GBNEFtMZz6UqSiGd0KFsEu
	uLr+62i/LG8TU6q8vvrm6uH1Ev+8Ucvy1oJtGMquN5Mi3IDDH5uO1OPnCdHcoZcl2qQsIv+k/3D
	YQsPV/2nDWH151DFcAfrsaorOWNASwrBrxSRN3Sp7e/ELz2wvGkvzT81E2YFooHsy3WG5Xs4+ml
	IH5ocfrE8KztEwoF3+A8ZKxcrcGG7nA6quK/DjYGfd39Cv8s5nN+eds1nipJseDNx7lB5VJj5TC
	5hUwlaCtseISCk2AKtMQh2jGW55LNKNc8YdubLug==
X-Google-Smtp-Source: AGHT+IFWxuCrt1g+QcxkI8hg0Rxi2ScVPu4cLf7cmb1Wgit3BHjEWipTfDOoGounF2+DVntAl4eQgw==
X-Received: by 2002:a05:6402:34c1:b0:640:cc76:ae35 with SMTP id 4fb4d7f45d1cf-6415e823375mr2370151a12.21.1762629807910;
        Sat, 08 Nov 2025 11:23:27 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e0cesm7284377a12.33.2025.11.08.11.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:23:27 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v2 wireless-next 4/4] wifi: mac80211_hwsim: background CAC support
Date: Sat,  8 Nov 2025 20:22:39 +0100
Message-ID: <20251108192239.2830459-4-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
References: <20251108192239.2830459-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report background CAC support and add option
to simulate background CAC radar event.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 9a1b5144aa1f..0f85e37adf34 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -715,6 +715,7 @@ struct mac80211_hwsim_data {
 	} ps;
 	bool ps_poll_pending;
 	struct dentry *debugfs;
+	struct cfg80211_chan_def radar_background_chandef;
 
 	atomic_t pending_cookie;
 	struct sk_buff_head pending;	/* packets pending */
@@ -1164,6 +1165,24 @@ static int hwsim_write_simulate_radar(void *dat, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(hwsim_simulate_radar, NULL,
 			 hwsim_write_simulate_radar, "%llu\n");
 
+static int hwsim_write_simulate_background_radar(void *dat, u64 val)
+{
+	struct mac80211_hwsim_data *data = dat;
+
+	/* Check if background radar channel is configured */
+	if (!data->radar_background_chandef.chan)
+		return -EINVAL;
+
+	cfg80211_background_radar_event(data->hw->wiphy,
+					&data->radar_background_chandef,
+					GFP_KERNEL);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(hwsim_simulate_background_radar, NULL,
+			 hwsim_write_simulate_background_radar, "%llu\n");
+
 static int hwsim_fops_group_read(void *dat, u64 *val)
 {
 	struct mac80211_hwsim_data *data = dat;
@@ -4148,6 +4167,20 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int mac80211_hwsim_set_radar_background(struct ieee80211_hw *hw,
+					       struct cfg80211_chan_def *chandef)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+
+	if (chandef)
+		data->radar_background_chandef = *chandef;
+	else
+		memset(&data->radar_background_chandef, 0,
+		       sizeof(data->radar_background_chandef));
+
+	return 0;
+}
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 #define HWSIM_DEBUGFS_OPS					\
 	.link_add_debugfs = mac80211_hwsim_link_add_debugfs,
@@ -4183,6 +4216,7 @@ static int mac80211_hwsim_change_nan_config(struct ieee80211_hw *hw,
 	.start_nan = mac80211_hwsim_start_nan,                  \
 	.stop_nan = mac80211_hwsim_stop_nan,                    \
 	.nan_change_conf = mac80211_hwsim_change_nan_config,    \
+	.set_radar_background = mac80211_hwsim_set_radar_background, \
 	HWSIM_DEBUGFS_OPS
 
 #define HWSIM_NON_MLO_OPS					\
@@ -5788,6 +5822,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_DFS_CONCURRENT);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_RADAR_BACKGROUND);
 
 	if (param->no_vif)
 		ieee80211_hw_set(hw, NO_AUTO_VIF);
@@ -5822,10 +5858,14 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			    &hwsim_fops_group);
 	debugfs_create_file("rx_rssi", 0666, data->debugfs, data,
 			    &hwsim_fops_rx_rssi);
-	if (!data->use_chanctx)
+	if (!data->use_chanctx) {
 		debugfs_create_file("dfs_simulate_radar", 0222,
 				    data->debugfs,
 				    data, &hwsim_simulate_radar);
+		debugfs_create_file("dfs_simulate_background_radar", 0200,
+				    data->debugfs,
+				    data, &hwsim_simulate_background_radar);
+	}
 
 	if (param->pmsr_capa) {
 		data->pmsr_capa = *param->pmsr_capa;
-- 
2.43.0


