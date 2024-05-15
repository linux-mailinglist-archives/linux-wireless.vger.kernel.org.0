Return-Path: <linux-wireless+bounces-7676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD78C61DE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1161F21B20
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D045970;
	Wed, 15 May 2024 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="scrFh20h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEBE4AEE0
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758752; cv=none; b=pdGDSlJrawLsjEj0Mo0FAYaNHZ6+Th+3H8yG2qR5IlGro9OxeFlQXw1zbSqJktM6KclsV4A1j+Sz3/TJ1Z47Zn/2Z+sH62RhK2TePObFPaPBfF8zDsN/cU0aDoO30JmN8L3s5eGna0pZzrJBZJEZ50jUj3nX/VM92766AQ2+il4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758752; c=relaxed/simple;
	bh=vE655lkZ+giIvMfhM1Q/JWJ4Ic2FVr+Ha0Xz8wkvmSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TukMvKknTZvEjfdO9mZWFizbWUTFQ/t7bDlPcbzmdyrSKubLRZjv/OKTML9LZ9QYa8U0PcyIbxKaqn8jcZWmZHg4FHCyWpR31c5GSvUjufeoOq/cojQ8Msy/Jh+Bewyc8P2t0yQ16C0xYGFoNqeGzcniQQup85FdVNhIZdzpfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=scrFh20h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BSc3J+M2Wd4t5XYUAIgz5sx2n0p6sCo7lDO+/LcA5p4=;
	t=1715758749; x=1716968349; b=scrFh20hw67ZGtoyU4/pJESfHNXt7723lKtwaJfd/aToOBR
	BEG8OdYR7+IiAmh1VCJAPoaXMYVYPJW6ztw3O/EE0IxtojkH2k/ZRQz3c+HCtEhcRNflY/2xcWSd0
	baacDRN7NOqaCYAze+PmOKZSPNZIsf50Jc48L/YLvZgJHX0JoV82y/vHs2uGhHKVUE3GWpNC5TBpF
	C/9vIiuUSPp/dEuzFlbpHVdg6/Ij5YcWHQKJ6liVQfD/zwXYUAIEzpYUunWB5A1lHjyx78R/RoE64
	tNsrwqxoji7UNhXl9PsXMrOzURikZ4qDnVjaymHjV9tbooQwBmiwKXf7b4CQt6Ug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s79EA-000000063rL-1XRu;
	Wed, 15 May 2024 09:39:06 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/6] wifi: ieee80211: document function return values
Date: Wed, 15 May 2024 09:38:39 +0200
Message-ID: <20240515093852.1cd5ad8f354d.Idc16e9767fa42de80b659c32efc58aea38c26996@changeid>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240515073852.11273-8-johannes@sipsolutions.net>
References: <20240515073852.11273-8-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These are all missing, as pointed out when running kernel-doc.
Add return value documentation and fix some small things while
at it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 106 ++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 22 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 72b351abb4f6..595f83783f0e 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -373,6 +373,7 @@ struct ieee80211_trigger {
 /**
  * ieee80211_has_tods - check if IEEE80211_FCTL_TODS is set
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame has to-DS set
  */
 static inline bool ieee80211_has_tods(__le16 fc)
 {
@@ -382,6 +383,7 @@ static inline bool ieee80211_has_tods(__le16 fc)
 /**
  * ieee80211_has_fromds - check if IEEE80211_FCTL_FROMDS is set
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame has from-DS set
  */
 static inline bool ieee80211_has_fromds(__le16 fc)
 {
@@ -391,6 +393,7 @@ static inline bool ieee80211_has_fromds(__le16 fc)
 /**
  * ieee80211_has_a4 - check if IEEE80211_FCTL_TODS and IEEE80211_FCTL_FROMDS are set
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not it's a 4-address frame (from-DS and to-DS set)
  */
 static inline bool ieee80211_has_a4(__le16 fc)
 {
@@ -401,6 +404,7 @@ static inline bool ieee80211_has_a4(__le16 fc)
 /**
  * ieee80211_has_morefrags - check if IEEE80211_FCTL_MOREFRAGS is set
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame has more fragments (more frags bit set)
  */
 static inline bool ieee80211_has_morefrags(__le16 fc)
 {
@@ -410,6 +414,7 @@ static inline bool ieee80211_has_morefrags(__le16 fc)
 /**
  * ieee80211_has_retry - check if IEEE80211_FCTL_RETRY is set
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the retry flag is set
  */
 static inline bool ieee80211_has_retry(__le16 fc)
 {
@@ -419,6 +424,7 @@ static inline bool ieee80211_has_retry(__le16 fc)
 /**
  * ieee80211_has_pm - check if IEEE80211_FCTL_PM is set
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the power management flag is set
  */
 static inline bool ieee80211_has_pm(__le16 fc)
 {
@@ -428,6 +434,7 @@ static inline bool ieee80211_has_pm(__le16 fc)
 /**
  * ieee80211_has_moredata - check if IEEE80211_FCTL_MOREDATA is set
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the more data flag is set
  */
 static inline bool ieee80211_has_moredata(__le16 fc)
 {
@@ -437,6 +444,7 @@ static inline bool ieee80211_has_moredata(__le16 fc)
 /**
  * ieee80211_has_protected - check if IEEE80211_FCTL_PROTECTED is set
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the protected flag is set
  */
 static inline bool ieee80211_has_protected(__le16 fc)
 {
@@ -446,6 +454,7 @@ static inline bool ieee80211_has_protected(__le16 fc)
 /**
  * ieee80211_has_order - check if IEEE80211_FCTL_ORDER is set
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the order flag is set
  */
 static inline bool ieee80211_has_order(__le16 fc)
 {
@@ -455,6 +464,7 @@ static inline bool ieee80211_has_order(__le16 fc)
 /**
  * ieee80211_is_mgmt - check if type is IEEE80211_FTYPE_MGMT
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame type is management
  */
 static inline bool ieee80211_is_mgmt(__le16 fc)
 {
@@ -465,6 +475,7 @@ static inline bool ieee80211_is_mgmt(__le16 fc)
 /**
  * ieee80211_is_ctl - check if type is IEEE80211_FTYPE_CTL
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame type is control
  */
 static inline bool ieee80211_is_ctl(__le16 fc)
 {
@@ -475,6 +486,7 @@ static inline bool ieee80211_is_ctl(__le16 fc)
 /**
  * ieee80211_is_data - check if type is IEEE80211_FTYPE_DATA
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a data frame
  */
 static inline bool ieee80211_is_data(__le16 fc)
 {
@@ -485,6 +497,7 @@ static inline bool ieee80211_is_data(__le16 fc)
 /**
  * ieee80211_is_ext - check if type is IEEE80211_FTYPE_EXT
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame type is extended
  */
 static inline bool ieee80211_is_ext(__le16 fc)
 {
@@ -496,6 +509,7 @@ static inline bool ieee80211_is_ext(__le16 fc)
 /**
  * ieee80211_is_data_qos - check if type is IEEE80211_FTYPE_DATA and IEEE80211_STYPE_QOS_DATA is set
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a QoS data frame
  */
 static inline bool ieee80211_is_data_qos(__le16 fc)
 {
@@ -510,6 +524,8 @@ static inline bool ieee80211_is_data_qos(__le16 fc)
 /**
  * ieee80211_is_data_present - check if type is IEEE80211_FTYPE_DATA and has data
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a QoS data frame that has data
+ *	(i.e. is not null data)
  */
 static inline bool ieee80211_is_data_present(__le16 fc)
 {
@@ -524,6 +540,7 @@ static inline bool ieee80211_is_data_present(__le16 fc)
 /**
  * ieee80211_is_assoc_req - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_ASSOC_REQ
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is an association request
  */
 static inline bool ieee80211_is_assoc_req(__le16 fc)
 {
@@ -534,6 +551,7 @@ static inline bool ieee80211_is_assoc_req(__le16 fc)
 /**
  * ieee80211_is_assoc_resp - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_ASSOC_RESP
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is an association response
  */
 static inline bool ieee80211_is_assoc_resp(__le16 fc)
 {
@@ -544,6 +562,7 @@ static inline bool ieee80211_is_assoc_resp(__le16 fc)
 /**
  * ieee80211_is_reassoc_req - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_REASSOC_REQ
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a reassociation request
  */
 static inline bool ieee80211_is_reassoc_req(__le16 fc)
 {
@@ -554,6 +573,7 @@ static inline bool ieee80211_is_reassoc_req(__le16 fc)
 /**
  * ieee80211_is_reassoc_resp - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_REASSOC_RESP
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a reassociation response
  */
 static inline bool ieee80211_is_reassoc_resp(__le16 fc)
 {
@@ -564,6 +584,7 @@ static inline bool ieee80211_is_reassoc_resp(__le16 fc)
 /**
  * ieee80211_is_probe_req - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_PROBE_REQ
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a probe request
  */
 static inline bool ieee80211_is_probe_req(__le16 fc)
 {
@@ -574,6 +595,7 @@ static inline bool ieee80211_is_probe_req(__le16 fc)
 /**
  * ieee80211_is_probe_resp - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_PROBE_RESP
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a probe response
  */
 static inline bool ieee80211_is_probe_resp(__le16 fc)
 {
@@ -584,6 +606,7 @@ static inline bool ieee80211_is_probe_resp(__le16 fc)
 /**
  * ieee80211_is_beacon - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_BEACON
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a (regular, not S1G) beacon
  */
 static inline bool ieee80211_is_beacon(__le16 fc)
 {
@@ -595,6 +618,7 @@ static inline bool ieee80211_is_beacon(__le16 fc)
  * ieee80211_is_s1g_beacon - check if IEEE80211_FTYPE_EXT &&
  * IEEE80211_STYPE_S1G_BEACON
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is an S1G beacon
  */
 static inline bool ieee80211_is_s1g_beacon(__le16 fc)
 {
@@ -618,6 +642,7 @@ static inline bool ieee80211_is_s1g_short_beacon(__le16 fc)
 /**
  * ieee80211_is_atim - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_ATIM
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is an ATIM frame
  */
 static inline bool ieee80211_is_atim(__le16 fc)
 {
@@ -628,6 +653,7 @@ static inline bool ieee80211_is_atim(__le16 fc)
 /**
  * ieee80211_is_disassoc - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_DISASSOC
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a disassociation frame
  */
 static inline bool ieee80211_is_disassoc(__le16 fc)
 {
@@ -638,6 +664,7 @@ static inline bool ieee80211_is_disassoc(__le16 fc)
 /**
  * ieee80211_is_auth - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_AUTH
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is an authentication frame
  */
 static inline bool ieee80211_is_auth(__le16 fc)
 {
@@ -648,6 +675,7 @@ static inline bool ieee80211_is_auth(__le16 fc)
 /**
  * ieee80211_is_deauth - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_DEAUTH
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a deauthentication frame
  */
 static inline bool ieee80211_is_deauth(__le16 fc)
 {
@@ -658,6 +686,7 @@ static inline bool ieee80211_is_deauth(__le16 fc)
 /**
  * ieee80211_is_action - check if IEEE80211_FTYPE_MGMT && IEEE80211_STYPE_ACTION
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is an action frame
  */
 static inline bool ieee80211_is_action(__le16 fc)
 {
@@ -668,6 +697,7 @@ static inline bool ieee80211_is_action(__le16 fc)
 /**
  * ieee80211_is_back_req - check if IEEE80211_FTYPE_CTL && IEEE80211_STYPE_BACK_REQ
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a block-ACK request frame
  */
 static inline bool ieee80211_is_back_req(__le16 fc)
 {
@@ -678,6 +708,7 @@ static inline bool ieee80211_is_back_req(__le16 fc)
 /**
  * ieee80211_is_back - check if IEEE80211_FTYPE_CTL && IEEE80211_STYPE_BACK
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a block-ACK frame
  */
 static inline bool ieee80211_is_back(__le16 fc)
 {
@@ -688,6 +719,7 @@ static inline bool ieee80211_is_back(__le16 fc)
 /**
  * ieee80211_is_pspoll - check if IEEE80211_FTYPE_CTL && IEEE80211_STYPE_PSPOLL
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a PS-poll frame
  */
 static inline bool ieee80211_is_pspoll(__le16 fc)
 {
@@ -698,6 +730,7 @@ static inline bool ieee80211_is_pspoll(__le16 fc)
 /**
  * ieee80211_is_rts - check if IEEE80211_FTYPE_CTL && IEEE80211_STYPE_RTS
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is an RTS frame
  */
 static inline bool ieee80211_is_rts(__le16 fc)
 {
@@ -708,6 +741,7 @@ static inline bool ieee80211_is_rts(__le16 fc)
 /**
  * ieee80211_is_cts - check if IEEE80211_FTYPE_CTL && IEEE80211_STYPE_CTS
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a CTS frame
  */
 static inline bool ieee80211_is_cts(__le16 fc)
 {
@@ -718,6 +752,7 @@ static inline bool ieee80211_is_cts(__le16 fc)
 /**
  * ieee80211_is_ack - check if IEEE80211_FTYPE_CTL && IEEE80211_STYPE_ACK
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is an ACK frame
  */
 static inline bool ieee80211_is_ack(__le16 fc)
 {
@@ -728,6 +763,7 @@ static inline bool ieee80211_is_ack(__le16 fc)
 /**
  * ieee80211_is_cfend - check if IEEE80211_FTYPE_CTL && IEEE80211_STYPE_CFEND
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a CF-end frame
  */
 static inline bool ieee80211_is_cfend(__le16 fc)
 {
@@ -738,6 +774,7 @@ static inline bool ieee80211_is_cfend(__le16 fc)
 /**
  * ieee80211_is_cfendack - check if IEEE80211_FTYPE_CTL && IEEE80211_STYPE_CFENDACK
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a CF-end-ack frame
  */
 static inline bool ieee80211_is_cfendack(__le16 fc)
 {
@@ -748,6 +785,7 @@ static inline bool ieee80211_is_cfendack(__le16 fc)
 /**
  * ieee80211_is_nullfunc - check if frame is a regular (non-QoS) nullfunc frame
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a nullfunc frame
  */
 static inline bool ieee80211_is_nullfunc(__le16 fc)
 {
@@ -758,6 +796,7 @@ static inline bool ieee80211_is_nullfunc(__le16 fc)
 /**
  * ieee80211_is_qos_nullfunc - check if frame is a QoS nullfunc frame
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a QoS nullfunc frame
  */
 static inline bool ieee80211_is_qos_nullfunc(__le16 fc)
 {
@@ -768,6 +807,7 @@ static inline bool ieee80211_is_qos_nullfunc(__le16 fc)
 /**
  * ieee80211_is_trigger - check if frame is trigger frame
  * @fc: frame control field in little-endian byteorder
+ * Return: whether or not the frame is a trigger frame
  */
 static inline bool ieee80211_is_trigger(__le16 fc)
 {
@@ -778,6 +818,7 @@ static inline bool ieee80211_is_trigger(__le16 fc)
 /**
  * ieee80211_is_any_nullfunc - check if frame is regular or QoS nullfunc frame
  * @fc: frame control bytes in little-endian byteorder
+ * Return: whether or not the frame is a nullfunc or QoS nullfunc frame
  */
 static inline bool ieee80211_is_any_nullfunc(__le16 fc)
 {
@@ -787,6 +828,8 @@ static inline bool ieee80211_is_any_nullfunc(__le16 fc)
 /**
  * ieee80211_is_first_frag - check if IEEE80211_SCTL_FRAG is not set
  * @seq_ctrl: frame sequence control bytes in little-endian byteorder
+ * Return: whether or not the frame is the first fragment (also true if
+ *	it's not fragmented at all)
  */
 static inline bool ieee80211_is_first_frag(__le16 seq_ctrl)
 {
@@ -796,6 +839,7 @@ static inline bool ieee80211_is_first_frag(__le16 seq_ctrl)
 /**
  * ieee80211_is_frag - check if a frame is a fragment
  * @hdr: 802.11 header of the frame
+ * Return: whether or not the frame is a fragment
  */
 static inline bool ieee80211_is_frag(struct ieee80211_hdr *hdr)
 {
@@ -2349,6 +2393,8 @@ struct ieee80211_eht_operation_info {
  * @max_vht_nss: current maximum NSS as advertised by the STA in
  *	operating mode notification, can be 0 in which case the
  *	capability data will be used to derive this (from MCS support)
+ * Return: The maximum NSS that can be used for the given bandwidth/MCS
+ *	combination
  *
  * Due to the VHT Extended NSS Bandwidth Support, the maximum NSS can
  * vary for a given BW/MCS. This function parses the data.
@@ -4317,6 +4363,7 @@ struct ieee80211_he_6ghz_capa {
 /**
  * ieee80211_get_qos_ctl - get pointer to qos control bytes
  * @hdr: the frame
+ * Return: a pointer to the QoS control field in the frame header
  *
  * The qos ctrl bytes come after the frame_control, duration, seq_num
  * and 3 or 4 addresses of length ETH_ALEN. Checks frame_control to choose
@@ -4339,6 +4386,7 @@ static inline u8 *ieee80211_get_qos_ctl(struct ieee80211_hdr *hdr)
 /**
  * ieee80211_get_tid - get qos TID
  * @hdr: the frame
+ * Return: the TID from the QoS control field
  */
 static inline u8 ieee80211_get_tid(struct ieee80211_hdr *hdr)
 {
@@ -4350,6 +4398,7 @@ static inline u8 ieee80211_get_tid(struct ieee80211_hdr *hdr)
 /**
  * ieee80211_get_SA - get pointer to SA
  * @hdr: the frame
+ * Return: a pointer to the source address (SA)
  *
  * Given an 802.11 frame, this function returns the offset
  * to the source address (SA). It does not verify that the
@@ -4369,6 +4418,7 @@ static inline u8 *ieee80211_get_SA(struct ieee80211_hdr *hdr)
 /**
  * ieee80211_get_DA - get pointer to DA
  * @hdr: the frame
+ * Return: a pointer to the destination address (DA)
  *
  * Given an 802.11 frame, this function returns the offset
  * to the destination address (DA). It does not verify that
@@ -4387,6 +4437,7 @@ static inline u8 *ieee80211_get_DA(struct ieee80211_hdr *hdr)
 /**
  * ieee80211_is_bufferable_mmpdu - check if frame is bufferable MMPDU
  * @skb: the skb to check, starting with the 802.11 header
+ * Return: whether or not the MMPDU is bufferable
  */
 static inline bool ieee80211_is_bufferable_mmpdu(struct sk_buff *skb)
 {
@@ -4425,6 +4476,7 @@ static inline bool ieee80211_is_bufferable_mmpdu(struct sk_buff *skb)
 /**
  * _ieee80211_is_robust_mgmt_frame - check if frame is a robust management frame
  * @hdr: the frame (buffer must include at least the first octet of payload)
+ * Return: whether or not the frame is a robust management frame
  */
 static inline bool _ieee80211_is_robust_mgmt_frame(struct ieee80211_hdr *hdr)
 {
@@ -4461,6 +4513,7 @@ static inline bool _ieee80211_is_robust_mgmt_frame(struct ieee80211_hdr *hdr)
 /**
  * ieee80211_is_robust_mgmt_frame - check if skb contains a robust mgmt frame
  * @skb: the skb containing the frame, length will be checked
+ * Return: whether or not the frame is a robust management frame
  */
 static inline bool ieee80211_is_robust_mgmt_frame(struct sk_buff *skb)
 {
@@ -4473,6 +4526,7 @@ static inline bool ieee80211_is_robust_mgmt_frame(struct sk_buff *skb)
  * ieee80211_is_public_action - check if frame is a public action frame
  * @hdr: the frame
  * @len: length of the frame
+ * Return: whether or not the frame is a public action frame
  */
 static inline bool ieee80211_is_public_action(struct ieee80211_hdr *hdr,
 					      size_t len)
@@ -4518,8 +4572,9 @@ ieee80211_is_protected_dual_of_public_action(struct sk_buff *skb)
 
 /**
  * _ieee80211_is_group_privacy_action - check if frame is a group addressed
- * privacy action frame
+ *	privacy action frame
  * @hdr: the frame
+ * Return: whether or not the frame is a group addressed privacy action frame
  */
 static inline bool _ieee80211_is_group_privacy_action(struct ieee80211_hdr *hdr)
 {
@@ -4535,8 +4590,9 @@ static inline bool _ieee80211_is_group_privacy_action(struct ieee80211_hdr *hdr)
 
 /**
  * ieee80211_is_group_privacy_action - check if frame is a group addressed
- * privacy action frame
+ *	privacy action frame
  * @skb: the skb containing the frame, length will be checked
+ * Return: whether or not the frame is a group addressed privacy action frame
  */
 static inline bool ieee80211_is_group_privacy_action(struct sk_buff *skb)
 {
@@ -4548,6 +4604,7 @@ static inline bool ieee80211_is_group_privacy_action(struct sk_buff *skb)
 /**
  * ieee80211_tu_to_usec - convert time units (TU) to microseconds
  * @tu: the TUs
+ * Return: the time value converted to microseconds
  */
 static inline unsigned long ieee80211_tu_to_usec(unsigned long tu)
 {
@@ -4559,6 +4616,7 @@ static inline unsigned long ieee80211_tu_to_usec(unsigned long tu)
  * @tim: the TIM IE
  * @tim_len: length of the TIM IE
  * @aid: the AID to look for
+ * Return: whether or not traffic is indicated in the TIM for the given AID
  */
 static inline bool ieee80211_check_tim(const struct ieee80211_tim_ie *tim,
 				       u8 tim_len, u16 aid)
@@ -4585,8 +4643,10 @@ static inline bool ieee80211_check_tim(const struct ieee80211_tim_ie *tim,
 }
 
 /**
- * ieee80211_get_tdls_action - get tdls packet action (or -1, if not tdls packet)
+ * ieee80211_get_tdls_action - get TDLS action code
  * @skb: the skb containing the frame, length will not be checked
+ * Return: the TDLS action code, or -1 if it's not an encapsulated TDLS action
+ *	frame
  *
  * This function assumes the frame is a data frame, and that the network header
  * is in the correct place.
@@ -4626,6 +4686,7 @@ static inline int ieee80211_get_tdls_action(struct sk_buff *skb)
 /**
  * ieee80211_action_contains_tpc - checks if the frame contains TPC element
  * @skb: the skb containing the frame, length will be checked
+ * Return: %true if the frame contains a TPC element, %false otherwise
  *
  * This function checks if it's either TPC report action frame or Link
  * Measurement report action frame as defined in IEEE Std. 802.11-2012 8.5.2.5
@@ -4743,6 +4804,7 @@ struct element {
  * @element: element pointer after for_each_element() or friends
  * @data: same data pointer as passed to for_each_element() or friends
  * @datalen: same data length as passed to for_each_element() or friends
+ * Return: %true if all elements were iterated, %false otherwise; see notes
  *
  * This function returns %true if all the data was parsed or considered
  * while walking the elements. Only use this if your for_each_element()
@@ -4946,6 +5008,7 @@ struct ieee80211_mle_tdls_common_info {
  * ieee80211_mle_common_size - check multi-link element common size
  * @data: multi-link element, must already be checked for size using
  *	ieee80211_mle_size_ok()
+ * Return: the size of the multi-link element's "common" subfield 
  */
 static inline u8 ieee80211_mle_common_size(const u8 *data)
 {
@@ -4978,11 +5041,10 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 /**
  * ieee80211_mle_get_link_id - returns the link ID
  * @data: the basic multi link element
+ * Return: the link ID, or -1 if not present
  *
  * The element is assumed to be of the correct type (BASIC) and big enough,
  * this must be checked using ieee80211_mle_type_ok().
- *
- * If the BSS link ID can't be found, -1 will be returned
  */
 static inline int ieee80211_mle_get_link_id(const u8 *data)
 {
@@ -5002,12 +5064,10 @@ static inline int ieee80211_mle_get_link_id(const u8 *data)
 /**
  * ieee80211_mle_get_bss_param_ch_cnt - returns the BSS parameter change count
  * @data: pointer to the basic multi link element
+ * Return: the BSS Parameter Change Count field value, or -1 if not present
  *
  * The element is assumed to be of the correct type (BASIC) and big enough,
  * this must be checked using ieee80211_mle_type_ok().
- *
- * If the BSS parameter change count value can't be found (the presence bit
- * for it is clear), -1 will be returned.
  */
 static inline int
 ieee80211_mle_get_bss_param_ch_cnt(const u8 *data)
@@ -5030,13 +5090,13 @@ ieee80211_mle_get_bss_param_ch_cnt(const u8 *data)
 
 /**
  * ieee80211_mle_get_eml_med_sync_delay - returns the medium sync delay
- * @data: pointer to the multi link EHT IE
+ * @data: pointer to the multi-link element
+ * Return: the medium synchronization delay field value from the multi-link
+ *	element, or the default value (%IEEE80211_MED_SYNC_DELAY_DEFAULT)
+ *	if not present
  *
  * The element is assumed to be of the correct type (BASIC) and big enough,
  * this must be checked using ieee80211_mle_type_ok().
- *
- * If the medium synchronization is not present, then the default value is
- * returned.
  */
 static inline u16 ieee80211_mle_get_eml_med_sync_delay(const u8 *data)
 {
@@ -5060,12 +5120,12 @@ static inline u16 ieee80211_mle_get_eml_med_sync_delay(const u8 *data)
 
 /**
  * ieee80211_mle_get_eml_cap - returns the EML capability
- * @data: pointer to the multi link EHT IE
+ * @data: pointer to the multi-link element
+ * Return: the EML capability field value from the multi-link element,
+ *	or 0 if not present
  *
  * The element is assumed to be of the correct type (BASIC) and big enough,
  * this must be checked using ieee80211_mle_type_ok().
- *
- * If the EML capability is not present, 0 will be returned.
  */
 static inline u16 ieee80211_mle_get_eml_cap(const u8 *data)
 {
@@ -5091,13 +5151,12 @@ static inline u16 ieee80211_mle_get_eml_cap(const u8 *data)
 
 /**
  * ieee80211_mle_get_mld_capa_op - returns the MLD capabilities and operations.
- * @data: pointer to the multi link EHT IE
+ * @data: pointer to the multi-link element
+ * Return: the MLD capabilities and operations field value from the multi-link
+ *	element, or 0 if not present
  *
  * The element is assumed to be of the correct type (BASIC) and big enough,
  * this must be checked using ieee80211_mle_type_ok().
- *
- * If the MLD capabilities and operations field is not present, 0 will be
- * returned.
  */
 static inline u16 ieee80211_mle_get_mld_capa_op(const u8 *data)
 {
@@ -5128,12 +5187,11 @@ static inline u16 ieee80211_mle_get_mld_capa_op(const u8 *data)
 
 /**
  * ieee80211_mle_get_mld_id - returns the MLD ID
- * @data: pointer to the multi link element
+ * @data: pointer to the multi-link element
+ * Return: The MLD ID in the given multi-link element, or 0 if not present
  *
  * The element is assumed to be of the correct type (BASIC) and big enough,
  * this must be checked using ieee80211_mle_type_ok().
- *
- * If the MLD ID is not present, 0 will be returned.
  */
 static inline u8 ieee80211_mle_get_mld_id(const u8 *data)
 {
@@ -5168,6 +5226,7 @@ static inline u8 ieee80211_mle_get_mld_id(const u8 *data)
  * ieee80211_mle_size_ok - validate multi-link element size
  * @data: pointer to the element data
  * @len: length of the containing element
+ * Return: whether or not the multi-link element size is OK
  */
 static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 {
@@ -5237,6 +5296,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
  * @data: pointer to the element data
  * @type: expected type of the element
  * @len: length of the containing element
+ * Return: whether or not the multi-link element type matches and size is OK
  */
 static inline bool ieee80211_mle_type_ok(const u8 *data, u8 type, size_t len)
 {
@@ -5280,6 +5340,7 @@ struct ieee80211_mle_per_sta_profile {
  *	profile size
  * @data: pointer to the sub element data
  * @len: length of the containing sub element
+ * Return: %true if the STA profile is large enough, %false otherwise
  */
 static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
 							size_t len)
@@ -5364,6 +5425,7 @@ ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(const struct ieee80211_mle_per_sta
  *	element sta profile size.
  * @data: pointer to the sub element data
  * @len: length of the containing sub element
+ * Return: %true if the STA profile is large enough, %false otherwise
  */
 static inline bool ieee80211_mle_reconf_sta_prof_size_ok(const u8 *data,
 							 size_t len)
-- 
2.45.0


