Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC1D2BBF13
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Nov 2020 13:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgKUMwZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Nov 2020 07:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgKUMwY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Nov 2020 07:52:24 -0500
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Nov 2020 04:52:24 PST
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [IPv6:2001:67c:2050:101:465::105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C1C0613CF
        for <linux-wireless@vger.kernel.org>; Sat, 21 Nov 2020 04:52:24 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4CdY6B4Py0zQlRd;
        Sat, 21 Nov 2020 13:45:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nyantec.com; h=
        content-language:content-transfer-encoding:content-type
        :content-type:mime-version:date:date:message-id:subject:subject
        :from:from:received; s=default; t=1605962703; bh=0QBlA1vZZQcwKLR
        3QYwJeEpFV77i1d1t/cYxXFzfE8c=; b=f+6veuKyWB3jVxQ0DelKUle0eMwZhMW
        2BLJBT/f+jCADvrxjLhe35Njv8b5Gca2nyOBT6Bm+CpyQ8SXiQ5B3iIhjzPzZIdx
        OpqqkHc4bIvK0N3GqdKQIZ2Ne4lyJBmKEmA78FAHqvQPR3djWEt8eFy3ocsTUn2W
        UpkeXj/v1i14HCtC3p2lDM3pnuEaWm87SYyyoLWDiU+g8V6HdWNeXoOtlFjMhsQo
        5vR0gBQ7hyMIGLjHT1BVaF1gxkHatiUhXIl4HSH8YWx/8FhLxoTaV+6C6ecGmYpe
        40vQgGp3hqFfmNnN1jkRoKIUhBH3S9qOrFOE3GyxD5/rwzIOnLcZ7iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1605962704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0QBlA1vZZQcwKLR3QYwJeEpFV77i1d1t/cYxXFzfE8c=;
        b=X9cLgxEY6wTzEJUQ7uTrH2DoSAlUgLXkDpkzjIku41eav34agkB1yPpecStHyiawncs4KR
        UUzqmRYyJDDdSs4PMVai4j0XhtwGYc4k9vDf74M87FlqfgKH4JTw0Ig9AiuaTwy/D6s5oO
        dEhSKagwMnx9GOQiCAgLY9I8gRPuJ3T9rAIGP/jJ2OXUs3BHiK14QrqXjggI990ZNvSpsc
        S7Q23KHrQ8IK1AcqQ/SqRy9P+HveisGcHfi6lNvaYOMbBuZzk82VcRL04unvz53qAJKRLT
        dCCrUpqGnV6qM3STxA5QBpYxbqJRb+VAbyNg1wRgvpWLXBwsgjZuthlVID2uwg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id J-WpkNsBQwxT; Sat, 21 Nov 2020 13:45:03 +0100 (CET)
From:   Finn Behrens <fin@nyantec.com>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] nl80211: reset regdom when reloading regdb
Message-ID: <8c3e46ac-331b-0922-5379-0cb1ef61a83b@nyantec.com>
Date:   Sat, 21 Nov 2020 13:45:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.07 / 15.00 / 15.00
X-Rspamd-Queue-Id: 99A96170D
X-Rspamd-UID: a1ca09
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

reset the regdom when NL80211_CMD_RELOAD_REGDB is send

Signed-off-by: Finn Behrens <fin@nyantec.com>
---
include/net/regulatory.h | 1 +
net/wireless/reg.c | 31 +++++++++++++++++++++++++++++--
2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index 47f06f6f5a67..0cf9335431e0 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -83,6 +83,7 @@ struct regulatory_request {
enum nl80211_dfs_regions dfs_region;
bool intersect;
bool processed;
+ bool reload;
enum environment_cap country_ie_env;
struct list_head list;
};
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index a04fdfb35f07..50314916b020 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -199,6 +199,7 @@ static struct regulatory_request *get_last_request(vo=
id)
/* Used to queue up regulatory hints */
static LIST_HEAD(reg_requests_list);
static spinlock_t reg_requests_lock;
+static void queue_regulatory_request(struct regulatory_request *request)=
;
/* Used to queue up beacon hints for review */
static LIST_HEAD(reg_pending_beacons);
@@ -1081,10 +1082,13 @@ int reg_reload_regdb(void)
int err;
err =3D request_firmware(&fw, "regulatory.db", &reg_pdev->dev);
- if (err)
+ if (err) {
+ pr_info("failed to load regulatory.db\n");
return err;
+ }
if (!valid_regdb(fw->data, fw->size)) {
+ pr_info("loaded regulatory.db is malformed or signature is
missing/invalid\n");
err =3D -ENODATA;
goto out;
}
@@ -1101,6 +1105,28 @@ int reg_reload_regdb(void)
regdb =3D db;
rtnl_unlock();
+ // reset regulatory
+ const struct ieee80211_regdomain *current_regdomain =3D NULL;
+
+ current_regdomain =3D get_cfg80211_regdom();
+
+ struct regulatory_request *request =3D NULL;
+
+ request =3D kzalloc(sizeof(*request), GFP_KERNEL);
+ if (!request) {
+ err =3D -ENOMEM;
+ goto out;
+ }
+
+ request->wiphy_idx =3D WIPHY_IDX_INVALID;
+ request->alpha2[0] =3D current_regdomain->alpha2[0];
+ request->alpha2[1] =3D current_regdomain->alpha2[1];
+ request->initiator =3D NL80211_USER_REG_HINT_USER;
+ request->user_reg_hint_type =3D NL80211_USER_REG_HINT_USER;
+ request->reload =3D true;
+
+ queue_regulatory_request(request);
+
out:
release_firmware(fw);
return err;
@@ -2657,7 +2683,8 @@ reg_process_hint_user(struct regulatory_request
*user_request)
treatment =3D __reg_process_hint_user(user_request);
if (treatment =3D=3D REG_REQ_IGNORE ||
- treatment =3D=3D REG_REQ_ALREADY_SET)
+ treatment =3D=3D REG_REQ_ALREADY_SET &&
+ !user_request->reload)
return REG_REQ_IGNORE;
user_request->intersect =3D treatment =3D=3D REG_REQ_INTERSECT;

--=20
2.29.2


