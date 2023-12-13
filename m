Return-Path: <linux-wireless+bounces-728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD09810935
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 05:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE74A1F217BC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 04:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A6C147;
	Wed, 13 Dec 2023 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QIUYtj8c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7FBE;
	Tue, 12 Dec 2023 20:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=oR84zgWHmelOk2rpA2bzRDstgtdKWsBnUbdLrEkqeNQ=; b=QIUYtj8cEevD+3vlhYxL4SzeTR
	akm+PlG3fVP9H6+QIXRx+TUQ4y54sJ0njMWLga0bUcqN/whCtuib5BKmq44KnCDO7H5l3x0DRO7Hx
	mEotqRLnQmrAl00Un8ZMlE6Ql2DKSsyFS0Fwv3Ei4ATqeUT32ALj1PFPX/RGQipU+Q0UlLck8AJu8
	4UZ2AbSIO3sh+Qb7JqfUYekEypJv5X068p3CpvY8JxEYyZzSSpXVSH0fKs4K48dyyquMW5e1Yqrh7
	MnfNy2Q5hrkd2PTaqwWVwAahC8J/FbXRFGth7jA7VWhB2G+NP+nv3PihuWAeWPlmqNZneKs4HSdCx
	V48040uw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDH5X-00DbaP-2h;
	Wed, 13 Dec 2023 04:43:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] wifi: nl80211: fix grammar & spellos
Date: Tue, 12 Dec 2023 20:43:15 -0800
Message-ID: <20231213044315.19459-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling as reported by codespell.
Correct run-on sentences and other grammar issues.
Add hyphenation of adjectives.
Correct some punctuation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/uapi/linux/nl80211.h |   74 ++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff -- a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -72,7 +72,7 @@
  * For drivers supporting TDLS with external setup (WIPHY_FLAG_SUPPORTS_TDLS
  * and WIPHY_FLAG_TDLS_EXTERNAL_SETUP), the station lifetime is as follows:
  *  - a setup station entry is added, not yet authorized, without any rate
- *    or capability information, this just exists to avoid race conditions
+ *    or capability information; this just exists to avoid race conditions
  *  - when the TDLS setup is done, a single NL80211_CMD_SET_STATION is valid
  *    to add rate and capability information to the station and at the same
  *    time mark it authorized.
@@ -87,7 +87,7 @@
  * DOC: Frame transmission/registration support
  *
  * Frame transmission and registration support exists to allow userspace
- * management entities such as wpa_supplicant react to management frames
+ * management entities such as wpa_supplicant to react to management frames
  * that are not being handled by the kernel. This includes, for example,
  * certain classes of action frames that cannot be handled in the kernel
  * for various reasons.
@@ -113,7 +113,7 @@
  *
  * Frame transmission allows userspace to send for example the required
  * responses to action frames. It is subject to some sanity checking,
- * but many frames can be transmitted. When a frame was transmitted, its
+ * but many frames can be transmitted. When a frame is transmitted, its
  * status is indicated to the sending socket.
  *
  * For more technical details, see the corresponding command descriptions
@@ -123,7 +123,7 @@
 /**
  * DOC: Virtual interface / concurrency capabilities
  *
- * Some devices are able to operate with virtual MACs, they can have
+ * Some devices are able to operate with virtual MACs; they can have
  * more than one virtual interface. The capability handling for this
  * is a bit complex though, as there may be a number of restrictions
  * on the types of concurrency that are supported.
@@ -135,7 +135,7 @@
  * Once concurrency is desired, more attributes must be observed:
  * To start with, since some interface types are purely managed in
  * software, like the AP-VLAN type in mac80211 for example, there's
- * an additional list of these, they can be added at any time and
+ * an additional list of these; they can be added at any time and
  * are only restricted by some semantic restrictions (e.g. AP-VLAN
  * cannot be added without a corresponding AP interface). This list
  * is exported in the %NL80211_ATTR_SOFTWARE_IFTYPES attribute.
@@ -164,7 +164,7 @@
  * Packet coalesce feature helps to reduce number of received interrupts
  * to host by buffering these packets in firmware/hardware for some
  * predefined time. Received interrupt will be generated when one of the
- * following events occur.
+ * following events occurs.
  * a) Expiration of hardware timer whose expiration time is set to maximum
  * coalescing delay of matching coalesce rule.
  * b) Coalescing buffer in hardware reaches its limit.
@@ -174,7 +174,7 @@
  * rule.
  * a) Maximum coalescing delay
  * b) List of packet patterns which needs to be matched
- * c) Condition for coalescence. pattern 'match' or 'no match'
+ * c) Condition for coalescence: pattern 'match' or 'no match'
  * Multiple such rules can be created.
  */
 
@@ -213,7 +213,7 @@
 /**
  * DOC: FILS shared key authentication offload
  *
- * FILS shared key authentication offload can be advertized by drivers by
+ * FILS shared key authentication offload can be advertised by drivers by
  * setting @NL80211_EXT_FEATURE_FILS_SK_OFFLOAD flag. The drivers that support
  * FILS shared key authentication offload should be able to construct the
  * authentication and association frames for FILS shared key authentication and
@@ -239,7 +239,7 @@
  * The PMKSA can be maintained in userspace persistently so that it can be used
  * later after reboots or wifi turn off/on also.
  *
- * %NL80211_ATTR_FILS_CACHE_ID is the cache identifier advertized by a FILS
+ * %NL80211_ATTR_FILS_CACHE_ID is the cache identifier advertised by a FILS
  * capable AP supporting PMK caching. It specifies the scope within which the
  * PMKSAs are cached in an ESS. %NL80211_CMD_SET_PMKSA and
  * %NL80211_CMD_DEL_PMKSA are enhanced to allow support for PMKSA caching based
@@ -290,12 +290,12 @@
  * If the configuration needs to be applied for specific peer then the MAC
  * address of the peer needs to be passed in %NL80211_ATTR_MAC, otherwise the
  * configuration will be applied for all the connected peers in the vif except
- * any peers that have peer specific configuration for the TID by default; if
- * the %NL80211_TID_CONFIG_ATTR_OVERRIDE flag is set, peer specific values
+ * any peers that have peer-specific configuration for the TID by default; if
+ * the %NL80211_TID_CONFIG_ATTR_OVERRIDE flag is set, peer-specific values
  * will be overwritten.
  *
- * All this configuration is valid only for STA's current connection
- * i.e. the configuration will be reset to default when the STA connects back
+ * All this configuration is valid only for STA's current connection,
+ * i.e., the configuration will be reset to default when the STA connects back
  * after disconnection/roaming, and this configuration will be cleared when
  * the interface goes down.
  */
@@ -521,7 +521,7 @@
  *	%NL80211_ATTR_SCHED_SCAN_PLANS. If %NL80211_ATTR_SCHED_SCAN_PLANS is
  *	not specified and only %NL80211_ATTR_SCHED_SCAN_INTERVAL is specified,
  *	scheduled scan will run in an infinite loop with the specified interval.
- *	These attributes are mutually exculsive,
+ *	These attributes are mutually exclusive,
  *	i.e. NL80211_ATTR_SCHED_SCAN_INTERVAL must not be passed if
  *	NL80211_ATTR_SCHED_SCAN_PLANS is defined.
  *	If for some reason scheduled scan is aborted by the driver, all scan
@@ -552,7 +552,7 @@
  *	%NL80211_CMD_STOP_SCHED_SCAN command is received or when the interface
  *	is brought down while a scheduled scan was running.
  *
- * @NL80211_CMD_GET_SURVEY: get survey resuls, e.g. channel occupation
+ * @NL80211_CMD_GET_SURVEY: get survey results, e.g. channel occupation
  *      or noise level
  * @NL80211_CMD_NEW_SURVEY_RESULTS: survey data notification (as a reply to
  *	NL80211_CMD_GET_SURVEY and on the "scan" multicast group)
@@ -563,7 +563,7 @@
  *	using %NL80211_ATTR_SSID, %NL80211_ATTR_FILS_CACHE_ID,
  *	%NL80211_ATTR_PMKID, and %NL80211_ATTR_PMK in case of FILS
  *	authentication where %NL80211_ATTR_FILS_CACHE_ID is the identifier
- *	advertized by a FILS capable AP identifying the scope of PMKSA in an
+ *	advertised by a FILS capable AP identifying the scope of PMKSA in an
  *	ESS.
  * @NL80211_CMD_DEL_PMKSA: Delete a PMKSA cache entry, using %NL80211_ATTR_MAC
  *	(for the BSSID) and %NL80211_ATTR_PMKID or using %NL80211_ATTR_SSID,
@@ -607,7 +607,7 @@
  *	BSSID in case of station mode). %NL80211_ATTR_SSID is used to specify
  *	the SSID (mainly for association, but is included in authentication
  *	request, too, to help BSS selection. %NL80211_ATTR_WIPHY_FREQ +
- *	%NL80211_ATTR_WIPHY_FREQ_OFFSET is used to specify the frequence of the
+ *	%NL80211_ATTR_WIPHY_FREQ_OFFSET is used to specify the frequency of the
  *	channel in MHz. %NL80211_ATTR_AUTH_TYPE is used to specify the
  *	authentication type. %NL80211_ATTR_IE is used to define IEs
  *	(VendorSpecificInfo, but also including RSN IE and FT IEs) to be added
@@ -816,7 +816,7 @@
  *	reached.
  * @NL80211_CMD_SET_CHANNEL: Set the channel (using %NL80211_ATTR_WIPHY_FREQ
  *	and the attributes determining channel width) the given interface
- *	(identifed by %NL80211_ATTR_IFINDEX) shall operate on.
+ *	(identified by %NL80211_ATTR_IFINDEX) shall operate on.
  *	In case multiple channels are supported by the device, the mechanism
  *	with which it switches channels is implementation-defined.
  *	When a monitor interface is given, it can only switch channel while
@@ -888,7 +888,7 @@
  *	inform userspace of the new replay counter.
  *
  * @NL80211_CMD_PMKSA_CANDIDATE: This is used as an event to inform userspace
- *	of PMKSA caching dandidates.
+ *	of PMKSA caching candidates.
  *
  * @NL80211_CMD_TDLS_OPER: Perform a high-level TDLS command (e.g. link setup).
  *	In addition, this can be used as an event to request userspace to take
@@ -924,7 +924,7 @@
  *
  * @NL80211_CMD_PROBE_CLIENT: Probe an associated station on an AP interface
  *	by sending a null data frame to it and reporting when the frame is
- *	acknowleged. This is used to allow timing out inactive clients. Uses
+ *	acknowledged. This is used to allow timing out inactive clients. Uses
  *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_MAC. The command returns a
  *	direct reply with an %NL80211_ATTR_COOKIE that is later used to match
  *	up the event with the request. The event includes the same data and
@@ -1839,7 +1839,7 @@ enum nl80211_commands {
  *	using %CMD_CONTROL_PORT_FRAME.  If control port routing over NL80211 is
  *	to be used then userspace must also use the %NL80211_ATTR_SOCKET_OWNER
  *	flag. When used with %NL80211_ATTR_CONTROL_PORT_NO_PREAUTH, pre-auth
- *	frames are not forwared over the control port.
+ *	frames are not forwarded over the control port.
  *
  * @NL80211_ATTR_TESTDATA: Testmode data blob, passed through to the driver.
  *	We recommend using nested, driver-specific attributes within this.
@@ -1976,10 +1976,10 @@ enum nl80211_commands {
  *	bit. Depending on which antennas are selected in the bitmap, 802.11n
  *	drivers can derive which chainmasks to use (if all antennas belonging to
  *	a particular chain are disabled this chain should be disabled) and if
- *	a chain has diversity antennas wether diversity should be used or not.
+ *	a chain has diversity antennas whether diversity should be used or not.
  *	HT capabilities (STBC, TX Beamforming, Antenna selection) can be
  *	derived from the available chains after applying the antenna mask.
- *	Non-802.11n drivers can derive wether to use diversity or not.
+ *	Non-802.11n drivers can derive whether to use diversity or not.
  *	Drivers may reject configurations or RX/TX mask combinations they cannot
  *	support by returning -EINVAL.
  *
@@ -2549,7 +2549,7 @@ enum nl80211_commands {
  *	from successful FILS authentication and is used with
  *	%NL80211_CMD_CONNECT.
  *
- * @NL80211_ATTR_FILS_CACHE_ID: A 2-octet identifier advertized by a FILS AP
+ * @NL80211_ATTR_FILS_CACHE_ID: A 2-octet identifier advertised by a FILS AP
  *	identifying the scope of PMKSAs. This is used with
  *	@NL80211_CMD_SET_PMKSA and @NL80211_CMD_DEL_PMKSA.
  *
@@ -4174,7 +4174,7 @@ enum nl80211_wmm_rule {
  *	(100 * dBm).
  * @NL80211_FREQUENCY_ATTR_DFS_STATE: current state for DFS
  *	(enum nl80211_dfs_state)
- * @NL80211_FREQUENCY_ATTR_DFS_TIME: time in miliseconds for how long
+ * @NL80211_FREQUENCY_ATTR_DFS_TIME: time in milliseconds for how long
  *	this channel is in this DFS state.
  * @NL80211_FREQUENCY_ATTR_NO_HT40_MINUS: HT40- isn't possible with this
  *	channel as the control channel
@@ -5458,7 +5458,7 @@ enum nl80211_tx_rate_setting {
  *	(%NL80211_TID_CONFIG_ATTR_TIDS, %NL80211_TID_CONFIG_ATTR_OVERRIDE).
  * @NL80211_TID_CONFIG_ATTR_PEER_SUPP: same as the previous per-vif one, but
  *	per peer instead.
- * @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribue, if set indicates
+ * @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribute, if set indicates
  *	that the new configuration overrides all previous peer
  *	configurations, otherwise previous peer specific configurations
  *	should be left untouched.
@@ -5841,7 +5841,7 @@ enum nl80211_attr_coalesce_rule {
 
 /**
  * enum nl80211_coalesce_condition - coalesce rule conditions
- * @NL80211_COALESCE_CONDITION_MATCH: coalaesce Rx packets when patterns
+ * @NL80211_COALESCE_CONDITION_MATCH: coalesce Rx packets when patterns
  *	in a rule are matched.
  * @NL80211_COALESCE_CONDITION_NO_MATCH: coalesce Rx packets when patterns
  *	in a rule are not matched.
@@ -5940,7 +5940,7 @@ enum nl80211_if_combination_attrs {
  * enum nl80211_plink_state - state of a mesh peer link finite state machine
  *
  * @NL80211_PLINK_LISTEN: initial state, considered the implicit
- *	state of non existent mesh peer links
+ *	state of non-existent mesh peer links
  * @NL80211_PLINK_OPN_SNT: mesh plink open frame has been sent to
  *	this mesh peer
  * @NL80211_PLINK_OPN_RCVD: mesh plink open frame has been received
@@ -6233,7 +6233,7 @@ enum nl80211_feature_flags {
  *	request to use RRM (see %NL80211_ATTR_USE_RRM) with
  *	%NL80211_CMD_ASSOCIATE and %NL80211_CMD_CONNECT requests, which will set
  *	the ASSOC_REQ_USE_RRM flag in the association request even if
- *	NL80211_FEATURE_QUIET is not advertized.
+ *	NL80211_FEATURE_QUIET is not advertised.
  * @NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER: This device supports MU-MIMO air
  *	sniffer which means that it can be configured to hear packets from
  *	certain groups which can be configured by the
@@ -6245,7 +6245,7 @@ enum nl80211_feature_flags {
  *	the BSS that the interface that requested the scan is connected to
  *	(if available).
  * @NL80211_EXT_FEATURE_BSS_PARENT_TSF: Per BSS, this driver reports the
- *	time the last beacon/probe was received. For a non MLO connection, the
+ *	time the last beacon/probe was received. For a non-MLO connection, the
  *	time is the TSF of the BSS that the interface that requested the scan is
  *	connected to (if available). For an MLO connection, the time is the TSF
  *	of the BSS corresponding with link ID specified in the scan request (if
@@ -6253,7 +6253,7 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_SET_SCAN_DWELL: This driver supports configuration of
  *	channel dwell time.
  * @NL80211_EXT_FEATURE_BEACON_RATE_LEGACY: Driver supports beacon rate
- *	configuration (AP/mesh), supporting a legacy (non HT/VHT) rate.
+ *	configuration (AP/mesh), supporting a legacy (non-HT/VHT) rate.
  * @NL80211_EXT_FEATURE_BEACON_RATE_HT: Driver supports beacon rate
  *	configuration (AP/mesh) with HT rates.
  * @NL80211_EXT_FEATURE_BEACON_RATE_VHT: Driver supports beacon rate
@@ -6589,7 +6589,7 @@ enum nl80211_timeout_reason {
  *	request parameters IE in the probe request
  * @NL80211_SCAN_FLAG_ACCEPT_BCAST_PROBE_RESP: accept broadcast probe responses
  * @NL80211_SCAN_FLAG_OCE_PROBE_REQ_HIGH_TX_RATE: send probe request frames at
- *	rate of at least 5.5M. In case non OCE AP is discovered in the channel,
+ *	rate of at least 5.5M. In case non-OCE AP is discovered in the channel,
  *	only the first probe req in the channel will be sent in high rate.
  * @NL80211_SCAN_FLAG_OCE_PROBE_REQ_DEFERRAL_SUPPRESSION: allow probe request
  *	tx deferral (dot11FILSProbeDelay shall be set to 15ms)
@@ -6625,7 +6625,7 @@ enum nl80211_timeout_reason {
  *	received on the 2.4/5 GHz channels to actively scan only the 6GHz
  *	channels on which APs are expected to be found. Note that when not set,
  *	the scan logic would scan all 6GHz channels, but since transmission of
- *	probe requests on non PSC channels is limited, it is highly likely that
+ *	probe requests on non-PSC channels is limited, it is highly likely that
  *	these channels would passively be scanned. Also note that when the flag
  *	is set, in addition to the colocated APs, PSC channels would also be
  *	scanned if the user space has asked for it.
@@ -6957,7 +6957,7 @@ enum nl80211_nan_func_term_reason {
  *	The instance ID for the follow up Service Discovery Frame. This is u8.
  * @NL80211_NAN_FUNC_FOLLOW_UP_REQ_ID: relevant if the function's type
  *	is follow up. This is a u8.
- *	The requestor instance ID for the follow up Service Discovery Frame.
+ *	The requester instance ID for the follow up Service Discovery Frame.
  * @NL80211_NAN_FUNC_FOLLOW_UP_DEST: the MAC address of the recipient of the
  *	follow up Service Discovery Frame. This is a binary attribute.
  * @NL80211_NAN_FUNC_CLOSE_RANGE: is this function limited for devices in a
@@ -7347,7 +7347,7 @@ enum nl80211_peer_measurement_attrs {
  * @NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED: flag attribute indicating if
  *	trigger based ranging measurement is supported
  * @NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED: flag attribute indicating
- *	if non trigger based ranging measurement is supported
+ *	if non-trigger-based ranging measurement is supported
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -7401,7 +7401,7 @@ enum nl80211_peer_measurement_ftm_capa {
  *      if neither %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED nor
  *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set, EDCA based
  *	ranging will be used.
- * @NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED: request non trigger based
+ * @NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED: request non-trigger-based
  *	ranging measurement (flag)
  *	This attribute and %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED are
  *	mutually exclusive.
@@ -7479,7 +7479,7 @@ enum nl80211_peer_measurement_ftm_failur
  * @NL80211_PMSR_FTM_RESP_ATTR_NUM_FTMR_ATTEMPTS: number of FTM Request frames
  *	transmitted (u32, optional)
  * @NL80211_PMSR_FTM_RESP_ATTR_NUM_FTMR_SUCCESSES: number of FTM Request frames
- *	that were acknowleged (u32, optional)
+ *	that were acknowledged (u32, optional)
  * @NL80211_PMSR_FTM_RESP_ATTR_BUSY_RETRY_TIME: retry time received from the
  *	busy peer (u32, seconds)
  * @NL80211_PMSR_FTM_RESP_ATTR_NUM_BURSTS_EXP: actual number of bursts exponent

