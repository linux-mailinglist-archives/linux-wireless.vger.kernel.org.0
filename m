Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255AF37AD95
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 20:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhEKSEY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 14:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhEKSEV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 14:04:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61DFC061760
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 11:03:10 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lgWiq-007aAS-FA
        for linux-wireless@vger.kernel.org; Tue, 11 May 2021 20:03:08 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 00/18] mac80211/driver security fixes
Date:   Tue, 11 May 2021 20:02:41 +0200
Message-Id: <20210511180259.159598-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Several security issues in the 802.11 implementations were found by
Mathy Vanhoef (New York University Abu Dhabi), who has published all
the details at

	https://papers.mathyvanhoef.com/usenix2021.pdf


Specifically, the following CVEs were assigned:

 * CVE-2020-24586 - Fragmentation cache not cleared on reconnection
 * CVE-2020-24587 - Reassembling fragments encrypted under different
                    keys
 * CVE-2020-24588 - Accepting non-SPP A-MSDU frames, which leads to
                    payload being parsed as an L2 frame under an
                    A-MSDU bit toggling attack
 * CVE-2020-26139 - Forwarding EAPOL from unauthenticated sender
 * CVE-2020-26140 - Accepting plaintext data frames in protected
                    networks
 * CVE-2020-26141 - Not verifying TKIP MIC of fragmented frames
 * CVE-2020-26142 - Processing fragmented frames as full frames
 * CVE-2020-26143 - Accepting fragmented plaintext frames in
                    protected networks
 * CVE-2020-26144 - Always accepting unencrypted A-MSDU frames that
                    start with RFC1042 header with EAPOL ethertype
 * CVE-2020-26145 - Accepting plaintext broadcast fragments as full
                    frames
 * CVE-2020-26146 - Reassembling encrypted fragments with non-consecutive
                    packet numbers
 * CVE-2020-26147 - Reassembling mixed encrypted/plaintext fragments


In general, the scope of these attacks is that they may allow an
attacker to
 * inject L2 frames that they can more or less control (depending on the
   vulnerability and attack method) into an otherwise protected network;
 * exfiltrate (some) network data under certain conditions, this is
   specific to the fragmentation issues.


A subset of these issues is known to apply to the Linux IEEE 802.11
implementation (mac80211). Where it is affected, the attached patches
fix the issues, even if not all of them reference the exact CVE IDs.

In addition, driver and/or firmware updates may be necessary, as well
as potentially more fixes to mac80211, depending on how drivers are
using it.

Specifically, for Intel devices, firmware needs to be updated to the
most recently released versions (which was done without any reference
to the security issues) to address some of the vulnerabilities.

To have a single set of patches, I'm also including patches for the
ath10k and ath11k drivers here.

We currently don't have information about how other drivers are, if
at all, affected.

johannes



