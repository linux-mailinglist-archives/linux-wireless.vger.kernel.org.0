Return-Path: <linux-wireless+bounces-4926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6018804CA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 19:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4681F23CE2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 18:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A5239AC4;
	Tue, 19 Mar 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OiNOiWmL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B7374D9;
	Tue, 19 Mar 2024 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872798; cv=none; b=TfVyAnV1GlOJG+7kA3PGVc0YFBEtZ//3qT8JNP/sD2VaZRWePpXoZyJ0N69euMccPlGSNcgHM2SaEIGIY2oBU5E4ldWQATtT1suzCh2Mid7F9PEOrvJY+lYPRU0RT6LK++KB2l/3k68tBf4SZndYCFGagu+KGLBeXSO7VsD31r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872798; c=relaxed/simple;
	bh=3oaOwJDmHHm0Bpf4PwjGqhyiAOBMyeHH0Y6/1qw8k+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NyrBjhtW+thGFsgg7ZQIgRC/BdM6CeXq08CyIYr6Cfg9t0pLwcT0FttL333PKGlzYJ9iwVvUSnpGWikAlnBk0MDqDHfXB82ULTNAISp24HnPPhptSmJKu0AGpDikdWL+nuUWh0ziF8DZr+V7Bt/JqE5bOVu8I8g4soLPyH4WlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OiNOiWmL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHGmOL031130;
	Tue, 19 Mar 2024 18:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=Wo6IuAot176XXHBBofVXbBT00QMiksuoYomgtVSv0FQ
	=; b=OiNOiWmL4/H4N5qKRyDf83kx9i9gjtgIxvRYO6DqhJJ5S45To9OgoFxHYMt
	PA3bTx8mAVW3jXgdEx1pnQ6+KF4Le61D2aX8nb+iYA+rh5+FH84sa+Z7T4rbdH9h
	lwVZmxNm1OS/QVb+fNywlIK8j4VwYQH6ERLZllGC+66td+KF1AnmZA/d3fnwLrDL
	BoYF3h4F6dhjjM/RbzF3sLQSQlpEvrxLqzZFuBAaP/UQft6ymfdcsUSJBL5o+iMj
	PEiDDtDWzep8/61NiB2kbfd8vOuegHKbrM4oIwei+FwU3/iGrhKiDrDHKwoAQpQs
	JJgqGS2sMUXmLOIBYKnBvNGwaxg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2e9j3kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:26:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JIQUGD017769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:26:30 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 11:26:29 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 19 Mar 2024 11:26:25 -0700
Subject: [PATCH 3/3] wifi: nl80211: cleanup nl80211.h kernel-doc
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240319-kdoc-nl80211-v1-3-549e09d52866@quicinc.com>
References: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
In-Reply-To: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: caxX43x3KxRmVEGYnlIydJ5_nAzUqbZ1
X-Proofpoint-ORIG-GUID: caxX43x3KxRmVEGYnlIydJ5_nAzUqbZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190138

Fix all of the kernel-doc issues in nl80211.h.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/uapi/linux/nl80211.h | 68 ++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4de84fbfd4fa..f917bc6c9b6f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -413,8 +413,8 @@
  *	are like for %NL80211_CMD_SET_BEACON, and additionally parameters that
  *	do not change are used, these include %NL80211_ATTR_BEACON_INTERVAL,
  *	%NL80211_ATTR_DTIM_PERIOD, %NL80211_ATTR_SSID,
- *	%NL80211_ATTR_HIDDEN_SSID, %NL80211_ATTR_CIPHERS_PAIRWISE,
- *	%NL80211_ATTR_CIPHER_GROUP, %NL80211_ATTR_WPA_VERSIONS,
+ *	%NL80211_ATTR_HIDDEN_SSID, %NL80211_ATTR_CIPHER_SUITES_PAIRWISE,
+ *	%NL80211_ATTR_CIPHER_SUITE_GROUP, %NL80211_ATTR_WPA_VERSIONS,
  *	%NL80211_ATTR_AKM_SUITES, %NL80211_ATTR_PRIVACY,
  *	%NL80211_ATTR_AUTH_TYPE, %NL80211_ATTR_INACTIVITY_TIMEOUT,
  *	%NL80211_ATTR_ACL_POLICY and %NL80211_ATTR_MAC_ADDRS.
@@ -451,11 +451,6 @@
  *	%NL80211_ATTR_MAC via %NL80211_ATTR_MPATH_NEXT_HOP.
  * @NL80211_CMD_DEL_MPATH: Delete a mesh path to the destination given by
  *	%NL80211_ATTR_MAC.
- * @NL80211_CMD_NEW_PATH: Add a mesh path with given attributes to the
- *	interface identified by %NL80211_ATTR_IFINDEX.
- * @NL80211_CMD_DEL_PATH: Remove a mesh path identified by %NL80211_ATTR_MAC
- *	or, if no MAC address given, all mesh paths, on the interface identified
- *	by %NL80211_ATTR_IFINDEX.
  * @NL80211_CMD_SET_BSS: Set BSS attributes for BSS identified by
  *	%NL80211_ATTR_IFINDEX.
  *
@@ -1120,7 +1115,7 @@
  *	current configuration is not changed.  If it is present but
  *	set to zero, the configuration is changed to don't-care
  *	(i.e. the device can decide what to do).
- * @NL80211_CMD_NAN_FUNC_MATCH: Notification sent when a match is reported.
+ * @NL80211_CMD_NAN_MATCH: Notification sent when a match is reported.
  *	This will contain a %NL80211_ATTR_NAN_MATCH nested attribute and
  *	%NL80211_ATTR_COOKIE.
  *
@@ -1862,12 +1857,6 @@ enum nl80211_commands {
  *	that protected APs should be used. This is also used with NEW_BEACON to
  *	indicate that the BSS is to use protection.
  *
- * @NL80211_ATTR_CIPHERS_PAIRWISE: Used with CONNECT, ASSOCIATE, and NEW_BEACON
- *	to indicate which unicast key ciphers will be used with the connection
- *	(an array of u32).
- * @NL80211_ATTR_CIPHER_GROUP: Used with CONNECT, ASSOCIATE, and NEW_BEACON to
- *	indicate which group key cipher will be used with the connection (a
- *	u32).
  * @NL80211_ATTR_WPA_VERSIONS: Used with CONNECT, ASSOCIATE, and NEW_BEACON to
  *	indicate which WPA version(s) the AP we want to associate with is using
  *	(a u32 with flags from &enum nl80211_wpa_versions).
@@ -1898,6 +1887,7 @@ enum nl80211_commands {
  *	with %NL80211_KEY_* sub-attributes
  *
  * @NL80211_ATTR_PID: Process ID of a network namespace.
+ * @NL80211_ATTR_NETNS_FD: File descriptor of a network namespace.
  *
  * @NL80211_ATTR_GENERATION: Used to indicate consistent snapshots for
  *	dumps. This number increases whenever the object list being
@@ -1952,6 +1942,7 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_ACK: Flag attribute indicating that the frame was
  *	acknowledged by the recipient.
+ * @NL80211_ATTR_ACK_SIGNAL: Station's ack signal strength (s32)
  *
  * @NL80211_ATTR_PS_STATE: powersave state, using &enum nl80211_ps_state values.
  *
@@ -2149,6 +2140,9 @@ enum nl80211_commands {
  * @NL80211_ATTR_DISABLE_HE: Force HE capable interfaces to disable
  *      this feature during association. This is a flag attribute.
  *	Currently only supported in mac80211 drivers.
+ * @NL80211_ATTR_DISABLE_EHT: Force EHT capable interfaces to disable
+ *      this feature during association. This is a flag attribute.
+ *	Currently only supported in mac80211 drivers.
  * @NL80211_ATTR_HT_CAPABILITY_MASK: Specify which bits of the
  *      ATTR_HT_CAPABILITY to which attention should be paid.
  *      Currently, only mac80211 NICs support this feature.
@@ -2158,6 +2152,12 @@ enum nl80211_commands {
  *      All values are treated as suggestions and may be ignored
  *      by the driver as required.  The actual values may be seen in
  *      the station debugfs ht_caps file.
+ * @NL80211_ATTR_VHT_CAPABILITY_MASK: Specify which bits of the
+ *      ATTR_VHT_CAPABILITY to which attention should be paid.
+ *      Currently, only mac80211 NICs support this feature.
+ *      All values are treated as suggestions and may be ignored
+ *      by the driver as required.  The actual values may be seen in
+ *      the station debugfs vht_caps file.
  *
  * @NL80211_ATTR_DFS_REGION: region for regulatory rules which this country
  *    abides to when initiating radiation on DFS channels. A country maps
@@ -3565,7 +3565,7 @@ enum nl80211_sta_flags {
  * enum nl80211_sta_p2p_ps_status - station support of P2P PS
  *
  * @NL80211_P2P_PS_UNSUPPORTED: station doesn't support P2P PS mechanism
- * @@NL80211_P2P_PS_SUPPORTED: station supports P2P PS mechanism
+ * @NL80211_P2P_PS_SUPPORTED: station supports P2P PS mechanism
  * @NUM_NL80211_P2P_PS_STATUS: number of values
  */
 enum nl80211_sta_p2p_ps_status {
@@ -3603,9 +3603,9 @@ enum nl80211_he_gi {
 
 /**
  * enum nl80211_he_ltf - HE long training field
- * @NL80211_RATE_INFO_HE_1xLTF: 3.2 usec
- * @NL80211_RATE_INFO_HE_2xLTF: 6.4 usec
- * @NL80211_RATE_INFO_HE_4xLTF: 12.8 usec
+ * @NL80211_RATE_INFO_HE_1XLTF: 3.2 usec
+ * @NL80211_RATE_INFO_HE_2XLTF: 6.4 usec
+ * @NL80211_RATE_INFO_HE_4XLTF: 12.8 usec
  */
 enum nl80211_he_ltf {
 	NL80211_RATE_INFO_HE_1XLTF,
@@ -3720,7 +3720,7 @@ enum nl80211_eht_ru_alloc {
  * @NL80211_RATE_INFO_HE_GI: HE guard interval identifier
  *	(u8, see &enum nl80211_he_gi)
  * @NL80211_RATE_INFO_HE_DCM: HE DCM value (u8, 0/1)
- * @NL80211_RATE_INFO_RU_ALLOC: HE RU allocation, if not present then
+ * @NL80211_RATE_INFO_HE_RU_ALLOC: HE RU allocation, if not present then
  *	non-OFDMA was used (u8, see &enum nl80211_he_ru_alloc)
  * @NL80211_RATE_INFO_320_MHZ_WIDTH: 320 MHz bitrate
  * @NL80211_RATE_INFO_EHT_MCS: EHT MCS index (u8, 0-15)
@@ -3852,8 +3852,8 @@ enum nl80211_sta_bss_param {
  *	Contains a nested array of signal strength attributes (u8, dBm)
  * @NL80211_STA_INFO_CHAIN_SIGNAL_AVG: per-chain signal strength average
  *	Same format as NL80211_STA_INFO_CHAIN_SIGNAL.
- * @NL80211_STA_EXPECTED_THROUGHPUT: expected throughput considering also the
- *	802.11 header (u32, kbps)
+ * @NL80211_STA_INFO_EXPECTED_THROUGHPUT: expected throughput considering also
+ *	the 802.11 header (u32, kbps)
  * @NL80211_STA_INFO_RX_DROP_MISC: RX packets dropped for unspecified reasons
  *	(u64)
  * @NL80211_STA_INFO_BEACON_RX: number of beacons received from this peer (u64)
@@ -4179,7 +4179,7 @@ enum nl80211_band_attr {
  * @NL80211_WMMR_CW_MAX: Maximum contention window slot.
  * @NL80211_WMMR_AIFSN: Arbitration Inter Frame Space.
  * @NL80211_WMMR_TXOP: Maximum allowed tx operation time.
- * @nl80211_WMMR_MAX: highest possible wmm rule.
+ * @NL80211_WMMR_MAX: highest possible wmm rule.
  * @__NL80211_WMMR_LAST: Internal use.
  */
 enum nl80211_wmm_rule {
@@ -4203,6 +4203,7 @@ enum nl80211_wmm_rule {
  * @NL80211_FREQUENCY_ATTR_NO_IR: no mechanisms that initiate radiation
  *	are permitted on this channel, this includes sending probe
  *	requests, or modes of operation that require beaconing.
+ * @__NL80211_FREQUENCY_ATTR_NO_IBSS: obsolete, same as _NO_IR
  * @NL80211_FREQUENCY_ATTR_RADAR: Radar detection is mandatory
  *	on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX_TX_POWER: Maximum transmission power in mBm
@@ -4357,7 +4358,7 @@ enum nl80211_bitrate_attr {
 };
 
 /**
- * enum nl80211_initiator - Indicates the initiator of a reg domain request
+ * enum nl80211_reg_initiator - Indicates the initiator of a reg domain request
  * @NL80211_REGDOM_SET_BY_CORE: Core queried CRDA for a dynamic world
  *	regulatory domain.
  * @NL80211_REGDOM_SET_BY_USER: User asked the wireless core to set the
@@ -4509,6 +4510,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_IR: no mechanisms that initiate radiation are allowed,
  *	this includes probe requests or modes of operation that require
  *	beaconing.
+ * @__NL80211_RRF_NO_IBSS: obsolete, same as NO_IR
  * @NL80211_RRF_AUTO_BW: maximum available bandwidth should be calculated
  *	base on contiguous rules and wider channels will be allowed to cross
  *	multiple contiguous/overlapping frequency ranges.
@@ -4707,8 +4709,8 @@ enum nl80211_mntr_flags {
  *	alternate between Active and Doze states, but may not wake up
  *	for neighbor's beacons.
  *
- * @__NL80211_MESH_POWER_AFTER_LAST - internal use
- * @NL80211_MESH_POWER_MAX - highest possible power save level
+ * @__NL80211_MESH_POWER_AFTER_LAST: internal use
+ * @NL80211_MESH_POWER_MAX: highest possible power save level
  */
 
 enum nl80211_mesh_power_mode {
@@ -5728,7 +5730,7 @@ struct nl80211_pattern_support {
  *	"TCP connection wakeup" for more details. This is a nested attribute
  *	containing the exact information for establishing and keeping alive
  *	the TCP connection.
- * @NL80211_WOWLAN_TRIG_TCP_WAKEUP_MATCH: For wakeup reporting only, the
+ * @NL80211_WOWLAN_TRIG_WAKEUP_TCP_MATCH: For wakeup reporting only, the
  *	wakeup packet was received on the TCP connection
  * @NL80211_WOWLAN_TRIG_WAKEUP_TCP_CONNLOST: For wakeup reporting only, the
  *	TCP connection was lost or failed to be established
@@ -6404,6 +6406,7 @@ enum nl80211_feature_flags {
  *	receiving control port frames over nl80211 instead of the netdevice.
  * @NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT: This driver/device supports
  *	(average) ACK signal strength reporting.
+ * @NL80211_EXT_FEATURE_DATA_ACK_SIGNAL_SUPPORT: Backward-compatible ID
  * @NL80211_EXT_FEATURE_TXQS: Driver supports FQ-CoDel-enabled intermediate
  *      TXQs.
  * @NL80211_EXT_FEATURE_SCAN_RANDOM_SN: Driver/device supports randomizing the
@@ -6787,6 +6790,8 @@ enum nl80211_acl_policy {
  * @NL80211_SMPS_STATIC: static SMPS (use a single antenna)
  * @NL80211_SMPS_DYNAMIC: dynamic smps (start with a single antenna and
  *	turn on other antennas after CTS/RTS).
+ * @__NL80211_SMPS_AFTER_LAST: internal
+ * @NL80211_SMPS_MAX: highest used enumeration
  */
 enum nl80211_smps_mode {
 	NL80211_SMPS_OFF,
@@ -7008,6 +7013,8 @@ enum nl80211_bss_select_attr {
  * @NL80211_NAN_FUNC_PUBLISH: function is publish
  * @NL80211_NAN_FUNC_SUBSCRIBE: function is subscribe
  * @NL80211_NAN_FUNC_FOLLOW_UP: function is follow-up
+ * @__NL80211_NAN_FUNC_TYPE_AFTER_LAST: internal use
+ * @NL80211_NAN_FUNC_MAX_TYPE: internal use
  */
 enum nl80211_nan_function_type {
 	NL80211_NAN_FUNC_PUBLISH,
@@ -7168,7 +7175,7 @@ enum nl80211_nan_match_attributes {
 };
 
 /**
- * nl80211_external_auth_action - Action to perform with external
+ * enum nl80211_external_auth_action - Action to perform with external
  *     authentication request. Used by NL80211_ATTR_EXTERNAL_AUTH_ACTION.
  * @NL80211_EXTERNAL_AUTH_START: Start the authentication.
  * @NL80211_EXTERNAL_AUTH_ABORT: Abort the ongoing authentication.
@@ -7186,7 +7193,7 @@ enum nl80211_external_auth_action {
  * @NL80211_FTM_RESP_ATTR_LCI: The content of Measurement Report Element
  *	(9.4.2.22 in 802.11-2016) with type 8 - LCI (9.4.2.22.10),
  *	i.e. starting with the measurement token
- * @NL80211_FTM_RESP_ATTR_CIVIC: The content of Measurement Report Element
+ * @NL80211_FTM_RESP_ATTR_CIVICLOC: The content of Measurement Report Element
  *	(9.4.2.22 in 802.11-2016) with type 11 - Civic (Section 9.4.2.22.13),
  *	i.e. starting with the measurement token
  * @__NL80211_FTM_RESP_ATTR_LAST: Internal
@@ -7829,6 +7836,7 @@ enum nl80211_sae_pwe_mechanism {
  *
  * @NL80211_SAR_TYPE_POWER: power limitation specified in 0.25dBm unit
  *
+ * @NUM_NL80211_SAR_TYPE: internal
  */
 enum nl80211_sar_type {
 	NL80211_SAR_TYPE_POWER,
@@ -7842,6 +7850,8 @@ enum nl80211_sar_type {
 /**
  * enum nl80211_sar_attrs - Attributes for SAR spec
  *
+ * @__NL80211_SAR_ATTR_INVALID: Invalid
+ *
  * @NL80211_SAR_ATTR_TYPE: the SAR type as defined in &enum nl80211_sar_type.
  *
  * @NL80211_SAR_ATTR_SPECS: Nested array of SAR power
@@ -7873,6 +7883,8 @@ enum nl80211_sar_attrs {
 /**
  * enum nl80211_sar_specs_attrs - Attributes for SAR power limit specs
  *
+ * @__NL80211_SAR_ATTR_SPECS_INVALID: Invalid
+ *
  * @NL80211_SAR_ATTR_SPECS_POWER: Required (s32)value to specify the actual
  *	power limit value in units of 0.25 dBm if type is
  *	NL80211_SAR_TYPE_POWER. (i.e., a value of 44 represents 11 dBm).

-- 
2.42.0


