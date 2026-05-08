Return-Path: <linux-wireless+bounces-36122-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH/hMspq/mn3qQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36122-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 00:59:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A634FC8AC
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 00:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03E3230219A4
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 22:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA5376467;
	Fri,  8 May 2026 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A29k9VK+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560523A7F6D
	for <linux-wireless@vger.kernel.org>; Fri,  8 May 2026 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281156; cv=none; b=Tavcg8xsmO2J+Gl3iw73f3pV6aYJ7iTZuP8hAxp0t83aE7RiG2kFOHYBiDsfQ79egmNpal6bmXQKjSSBDE/rtHxU3/G5S6DZ5b4FEhiXmm2HuMeJA+4Q6aAah7xPPArIYZUXt3nJZCgFjBEmI/Cmp+fY2RcpfmAYPUPKWuOhLqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281156; c=relaxed/simple;
	bh=5XtQkhT23owkfYE7/oQGvfHbFDsIFb863PL4UgPR+Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9MLKR8UZ4GOmYe9EoPYBpzpvbdHV8uVWXirGQ3fcc9eZDhS9j6pyx1EU5999e51RFZ6L7ElSZxXuk9kr5lDoBx9FgW6dWLPlS+L4hBgU/H5xj7zWGsKaiUNFHwy8JUeoWGlRGqiyAtZ9dN9tzdm2ilDhac3dlwFYgkgFixA4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A29k9VK+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-364eef1891dso2007339a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281155; x=1778885955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxJDbErB2Y0+/2u5sAL8YUpQDOeEJOrPLvUR3aNMlnM=;
        b=A29k9VK+0ax+ZknEvILguCDDGzNh38UYhzh9eiLvk188zAnQvofhY4Vh4cuvNF+Rmj
         Tq8EsqSmyruolT2KisV3jN5km7RpyJyIkNK2xKp++Jhw/NjmRJXKUNOm9Nm2WDJtaK1p
         qYqYuorpkBCylSNqSDhyebyZBV+agRbfsm8tsUCTiVYYGJV6OHx8lJuptjeBm6nF9mqV
         V057dY599uAKZIEZxxnS6LFsaoOPdE53MdnXkH0o9vz1RfSATJSgGuhLhYIYyG49aDHw
         x1ubWB4wJExsDLWqYCKEryaLH6gP5SmKRSlzykAdTCCFWeRwBLqc9dCDFSZSRPFoVMoY
         nWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281155; x=1778885955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zxJDbErB2Y0+/2u5sAL8YUpQDOeEJOrPLvUR3aNMlnM=;
        b=RjZIGaigt5O9uQtMfIbi2j1w7tB0H60Y4UFSSy72X9sE3gS+DZ7OIWnUxqIFUtqJE8
         fTZhJWSbbaFTdg0lL45cehq0DVNWrOW1Vth6TPtVpEusZrkfqm3M9lkUb3//6q5h/Op7
         09gH/hdX37a+swAYpDJKCI9NnsT1PChMEx2pq6UhVVuZKMLnptmKVf1sR7WTNd/B6/h1
         8HIAWPUSGjDVMT0AzI5iNw6PBrrCJvFF1fayKfC0aEpmvqVnRU9a/6F0QN9qT4mV//7z
         s7hvB2lHs5+ZPlrNfksW/RULmojTDaWGsGlzoBzu013/j9KStyNfFSXkB7VwQYRDlhxH
         Bk7A==
X-Gm-Message-State: AOJu0Yz8cHRJHamNvnJPZqa5xS6Ioq/HJzJBkhh3ETSLlFUvj1yZxJrI
	72mHQnCahjkm8JBi3kJU2oXJ/ZPCwNEUSgwlGs8h9Ep4hJaMlOxB6tTBJIN47w==
X-Gm-Gg: Acq92OF57mUEAUcaY7Lju0265y4AfzttSwOortdNs1o5sUkECEWsK75OEt/nHkhzIk8
	igKv8lAaEyW0u5s3QLBQxhtSEqyNEf0JtQIChm2U1RJ9WQlZF64+mQEBCvlQUl7YnCJIZDVsy14
	rdkNct/4D4mZUHUvuIE+k4PfD1VYvCOBIxg+zUv86H51rz08aqrH3lXM/A2ehDQJaIDN9VG0eaY
	bPl0Mj4DL9Mq2WN8Zs/Gb7o8GWXWgm80B7My8sv45jXujH/SLw0OT2Y3yb4/GyGYRSJ70gH3MFi
	RN9WtVX88pXdQJI3wF+vjDW3PewUtkITvWxyjoDY2S+3+Il0qathCME0SjT+SK4lgkfKMBgR8p3
	Ev7tiG6ZQpkqmp+WvJbfCX0FmzMyph0v7xB7udxxZksXavoAC89CqW2LoMBeGRmMoSZ7ZCoCHnr
	jsiCoMIg==
X-Received: by 2002:a17:90b:2884:b0:366:159a:c1ba with SMTP id 98e67ed59e1d1-3664c8db9acmr5325688a91.3.1778281154496;
        Fri, 08 May 2026 15:59:14 -0700 (PDT)
Received: from ryzen9.. ([2a02:6ea0:d33b:6276::23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d683fb92sm74472a91.12.2026.05.08.15.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:59:13 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH 2/3] Fix overread in PREP frame processing
Date: Sat,  9 May 2026 07:59:04 +0900
Message-ID: <20260508225905.29998-2-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508225905.29998-1-masashi.honma@gmail.com>
References: <8f0a2488540f4a65ea4d837a06225a27a10cc305.camel@sipsolutions.net>
 <20260508225905.29998-1-masashi.honma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43A634FC8AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36122-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

When the AF flag is enabled, hwmp_prep_frame_process() overreads orig_addr
by 2 bytes. Since this occurs within the socket buffer, it does not read across
memory boundaries and therefore poses no security risk; however, we will fix it
as a precaution.

In this fix, a new function mesh_path_parse_reply_frame() is established to
separate the implementation of frame format validation and the check for
unsupported features. This is intended to facilitate future work when
implementing the currently unsupported parts.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 net/mac80211/mesh.h      |  1 +
 net/mac80211/mesh_hwmp.c | 24 ++++++++++++++++++++++--
 net/mac80211/parse.c     |  7 +++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 331d2d774196..aba7ef59195a 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -318,6 +318,7 @@ mpp_path_lookup_by_idx(struct ieee80211_sub_if_data *sdata, int idx);
 void mesh_path_fix_nexthop(struct mesh_path *mpath, struct sta_info *next_hop);
 void mesh_path_expire(struct ieee80211_sub_if_data *sdata);
 u8 mesh_path_parse_request_frame(const u8 *pos, u8 elen);
+u8 mesh_path_parse_reply_frame(const u8 *pos, u8 elen);
 void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 			    struct ieee80211_mgmt *mgmt, size_t len);
 struct mesh_path *
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 4239412d12c7..9f903a2408f7 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -949,6 +949,25 @@ u8 mesh_path_parse_request_frame(const u8 *pos, u8 elen)
 	return 0;
 }
 
+/* IEEE Std 802.11-2016 9.4.2.114 PREP element */
+u8 mesh_path_parse_reply_frame(const u8 *pos, u8 elen)
+{
+	u8 expected_len;
+
+	expected_len = 1 /* Flags */ + 1 /* Hop Count */ + 1 /* Element TTL */ +
+		       6 /* Target Mesh STA Address */ +
+		       4 /* Target HWMP Sequence Number */ +
+		       (AE_F_SET(pos) ? 6 : 0) /* Target External Address */ +
+		       4 /* Lifetime */ + 4 /* Metric */ +
+		       6 /* Originator Mesh STA Address */ +
+		       4 /* Originator HWMP Sequence Number */;
+
+	if (unlikely(elen != expected_len))
+		return IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
+
+	return 0;
+}
+
 void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 			    struct ieee80211_mgmt *mgmt, size_t len)
 {
@@ -996,9 +1015,10 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 						path_metric);
 	}
 	if (elems->prep) {
-		if (elems->prep_len != 31)
-			/* Right now we support no AE */
+		/* Right now we do not support AE (Address Extension) */
+		if (AE_F_SET(elems->prep))
 			goto free;
+
 		path_metric = hwmp_route_info_get(sdata, mgmt, elems->prep,
 						  MPATH_PREP);
 		if (path_metric)
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 7a2abe676361..cdc549055242 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -554,8 +554,11 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			}
 			break;
 		case WLAN_EID_PREP:
-			elems->prep = pos;
-			elems->prep_len = elen;
+			elem_parse_failed = mesh_path_parse_reply_frame(pos, elen);
+			if (likely(!elem_parse_failed)) {
+				elems->prep = pos;
+				elems->prep_len = elen;
+			}
 			break;
 		case WLAN_EID_PERR:
 			elems->perr = pos;
-- 
2.43.0


