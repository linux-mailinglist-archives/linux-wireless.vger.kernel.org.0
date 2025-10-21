Return-Path: <linux-wireless+bounces-28156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC6CBF8CDA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 22:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F60481BAD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859E3285CAA;
	Tue, 21 Oct 2025 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMEQRAHp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED16F245014
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079916; cv=none; b=OQeYsoeX94/VfsWIl8Fynp8CbqpXsn/W/q2AwaPratAYjNimInjwixoNLHKj5UaJ4AHgN0Ov1CbsMTaRf+jZed3hyCdZHxwRr3AfTYFZVx2APs/upNeWfkYJpj4TT9gQaznZJ6TgTKD3lOPsE5TDiTnvQ6c20G9cQAnyqrB/csQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079916; c=relaxed/simple;
	bh=UveeWbonEBzHOsedwEkyFhZXsXP8dHRyWcqRFSsd9is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulGENnYaBaLUNW7KHmg7LteOuCLNRiCj2MEKLln6M5V6kETi56aywIH7k7qiloZrfy/l32MrR4XE6AaZX+USxUwu9DvD1eKKD2tSaS6n9SOCMSVhDtpzbbM+tCRs+kc7uEmpY2xf1Fi7tEGof4cYY8k/vXkaU8w0gI9cf4os07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMEQRAHp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso3917592a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079914; x=1761684714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lftas2ddDSmWmb+YGuwk3FBQVOltsQH5UlJvrmZ5q6U=;
        b=VMEQRAHp5d0MUi9apIanWr8EFTh9XMrXLK7jbqYnZt+v3idOmVv80UtivRn0Ef3YQv
         SUe5dg1cRPtxO/vb2ean9LiL7kmS9ev6TPezIKdJWVqSnS0yK7dEYJa/L6oK8dy5MLfx
         6g1HM9Cx/cg4qvgDkv3J7XVtYQvVEDPWIkVE9oq33liB1gYON1IFTa96Df8cCnjB+HJu
         2WUaxI9b9rrYwluKaSDtzd0zV74pj1sJh9ucqZ7quSUZQuUFyjtM0g5A6/S+K4o+fXjb
         9+k3JsHAttpayl+R4SdxMVYtpuLWGU/8pYo+pqaIUey74jqgQ/AN7SK1fi52woH+FVs3
         5ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079914; x=1761684714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lftas2ddDSmWmb+YGuwk3FBQVOltsQH5UlJvrmZ5q6U=;
        b=D4TNZwRqSS3hD130h7ZDswHTQbkk5FLNCAxwqsKhekl4Hj1yhgAvvW4rUN0iZC8ucZ
         REQbufXoY5n1HkABQxWLljStzoZoZXm0QwbeKQIWzTNvCL7mZbM9ub49jfa7JjRh8u+y
         P3ZMmipTFPtVDUMAUP7xNN9I16eu7lzruflZ4ZMxrDXn3zj4Y0mJdLhfujt3LLJDYFvH
         juFpzeDTAIMtKCcZFfawXd+7Jk/cYpNxMeje4mSsamz+vbbuJdazxL5bjDf7vS5Fbk5d
         DsHzqPr8eCAzSoHJW7uVcSC1pdRTHrpyYxRNgrM+mqFjHcbHImSnWZz04UxcvRJ2Xhb6
         fwxQ==
X-Gm-Message-State: AOJu0YzP8mfprc9JiZdJLW1xYhZ2CJU0cu/a8Ioc0g1tFv6YEhiXaZyv
	aym4uyfDjScUZjlpdhSTLgitS1Yp9foQSU6SKkzfosvQK2aAmPXCAD8v
X-Gm-Gg: ASbGncsPbp5zDEOf91+RDfb+roucbT+CfNFSqtsdUVS+oESBaqP74TH2MmRtqjEm8OE
	TXx4Op3imztMNnaite5sdlCyzoM5ybFJ79eEukj9ulSRK++Fhvp+O7V4Pj/3miYhlEzC7CgOLNt
	Xu/EuvQWBWpGR95XAcKQxAmW31pbDtbhp0lmRUPBEkygJVsOficgxYH/2TAXml75+bPwLNMa5S4
	9+pG3cicnrut7v++X6edxKpMBFSfzztubbQhufO22dh2GpIEhh4Vy/jQ5g0DNOZxjuyq5xs/Nbl
	HJSdfp6nP5DjUHaiNh2zmEpPirpCiJm7zeolmcytgKAu9EjNVxPmjJiGPb4QLG1MemLOCTCEGjm
	M5UG5nIbL/JAJvTyK0YtHh6SRqKRq9D/hATwOYjCFLlpWf2RcJX6jIt2VJ5exekkUCQ6DL7Lb8p
	CLzkIHztP7SDK/
X-Google-Smtp-Source: AGHT+IEfhRm0UFYKNj6H7qrDGgiGnDijmQN5E6l3vSDSR8fMiI77xk4Co+Iyyb2wZMvFpNiuKZWgVg==
X-Received: by 2002:a17:902:f610:b0:261:1521:17a8 with SMTP id d9443c01a7336-290c9ca6b06mr233478265ad.16.1761079914034;
        Tue, 21 Oct 2025 13:51:54 -0700 (PDT)
Received: from skylark ([171.50.223.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc795sm118283815ad.30.2025.10.21.13.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:51:53 -0700 (PDT)
From: Amol Dhamale <amoldhamale1105@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sriram.g@kpit.com,
	Amol Dhamale <amoldhamale1105@gmail.com>
Subject: [PATCH 3/4] wifi: mac80211_hwsim: add sufficient parantheses to complex macro
Date: Tue, 21 Oct 2025 20:50:25 +0000
Message-ID: <719536080163f4b8ecb9af6ebbb7af8304fe3401.1761078139.git.amoldhamale1105@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761078139.git.amoldhamale1105@gmail.com>
References: <cover.1761078139.git.amoldhamale1105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

ERROR: Macros with complex values should be enclosed in parentheses

Signed-off-by: Amol Dhamale <amoldhamale1105@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 51c0582e3b77..e62d4a98671f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5357,10 +5357,10 @@ static const u8 iftypes_ext_capa_ap[] = {
 };
 
 #define MAC80211_HWSIM_MLD_CAPA_OPS				\
-	FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
-			 IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) | \
-	FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS, \
-			 IEEE80211_MLD_MAX_NUM_LINKS - 1)
+	((FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
+			 IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME)) | \
+	(FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS, \
+			 IEEE80211_MLD_MAX_NUM_LINKS - 1)))
 
 static const struct wiphy_iftype_ext_capab mac80211_hwsim_iftypes_ext_capa[] = {
 	{
-- 
2.43.0


