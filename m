Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B46E798DE8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 20:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbjIHSZc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Sep 2023 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbjIHSZM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Sep 2023 14:25:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844354C3F;
        Fri,  8 Sep 2023 11:22:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F395C116B7;
        Fri,  8 Sep 2023 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197307;
        bh=M1SEUboSPYiiB6UY60gtnV2aLHbrgmGINt3ZwQqz7ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F23b9N5pv1BeU5L0ik6+jGfZ6m57KDPnFN8epT7kOi/mIUiohNrENHAcnhyPmcOrf
         dCweQcncmMckUzEnWaPDNhS3exb+0yP+AL5CxV3C7NQir3gv4Lbab9zQJ72EfNCETr
         wbptpzfe+7a8MdgBpctoL8ZZFWefqV7z8YItwOnTN3mJN9Gynk0VUXbfHxZGJ5ZsEw
         ssyiw0HRu/z6RPEnwEeQ4gfmrzW6kvWqLl8Lgzl8gJiicbTXqYsHFmJGGe/4S9dOBY
         +oJ7vt5vLxfFlprploOgm4uayV0/BINkyJCr/vOkExLfHaBmNjVpi86aj+llPXJd/3
         PScrCV4AzCS4A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 7/8] wifi: cfg80211: ocb: don't leave if not joined
Date:   Fri,  8 Sep 2023 14:21:26 -0400
Message-Id: <20230908182127.3461199-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182127.3461199-1-sashal@kernel.org>
References: <20230908182127.3461199-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.325
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit abc76cf552e13cfa88a204b362a86b0e08e95228 ]

If there's no OCB state, don't ask the driver/mac80211 to
leave, since that's just confusing. Since set/clear the
chandef state, that's a simple check.

Reported-by: syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/ocb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/ocb.c b/net/wireless/ocb.c
index e64dbf16330c4..73dd44e77a1a3 100644
--- a/net/wireless/ocb.c
+++ b/net/wireless/ocb.c
@@ -70,6 +70,9 @@ int __cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
 	if (!rdev->ops->leave_ocb)
 		return -EOPNOTSUPP;
 
+	if (!wdev->u.ocb.chandef.chan)
+		return -ENOTCONN;
+
 	err = rdev_leave_ocb(rdev, dev);
 	if (!err)
 		memset(&wdev->chandef, 0, sizeof(wdev->chandef));
-- 
2.40.1

