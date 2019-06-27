Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2795779B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 02:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfF0Ajs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jun 2019 20:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbfF0Ajr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jun 2019 20:39:47 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9641F21852;
        Thu, 27 Jun 2019 00:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595986;
        bh=0Pv95/2zdcKj3iOdjOBRzI6V+uNr9Um2slGpRBxcmC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9tmEuCIrXkpSJwZiyVdOtEqBAPfBdSBTbkRvUsX0Cbd4hC3FG9NXIP0GiCOF5iXD
         9KNzrRCAAfLjGXOpfGz3tSnD+MdeyxlITBPaWTAgSDIwKxuq4sHjWIhH3hB0vOyghd
         cTCJYt0fcYDvwm2iMYffkWskjSvcFtbBMfMxfzF0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 06/35] mac80211: free peer keys before vif down in mesh
Date:   Wed, 26 Jun 2019 20:38:54 -0400
Message-Id: <20190627003925.21330-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003925.21330-1-sashal@kernel.org>
References: <20190627003925.21330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

[ Upstream commit 0112fa557c3bb3a002bc85760dc3761d737264d3 ]

freeing peer keys after vif down is resulting in peer key uninstall
to fail due to interface lookup failure. so fix that.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index aca054539f4a..c6edae051e9b 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -922,6 +922,7 @@ void ieee80211_stop_mesh(struct ieee80211_sub_if_data *sdata)
 
 	/* flush STAs and mpaths on this iface */
 	sta_info_flush(sdata);
+	ieee80211_free_keys(sdata, true);
 	mesh_path_flush_by_iface(sdata);
 
 	/* stop the beacon */
-- 
2.20.1

