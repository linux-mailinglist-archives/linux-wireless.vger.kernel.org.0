Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781384B5DA4
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 23:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiBNWbO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 17:31:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiBNWbN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 17:31:13 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA3F70DB
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 14:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644877863; x=1676413863;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fPMkaW7lnuRBQtzbEI6gVMiIhkLeSg/x9ZoFgi4/0bY=;
  b=HZ114uqDZcvghxaNsA4091pqVRYaibwgUBFYuRHThSpZXANR/QQo6w23
   XEcDW+M8fJvlYJ6HS2hfro1v7UslWV2PCaARjQWScbDDaxytlnuUqeHs0
   Lzep9C9ugYUi7hw2hBFX4R+Rv39fEob1aFETTU1pDGzfIKWmTkqovbemM
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 14 Feb 2022 14:31:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 14:31:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 14:31:02 -0800
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 14:31:02 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 0/3] RU puncturing support
Date:   Mon, 14 Feb 2022 14:30:48 -0800
Message-ID: <20220214223051.3610-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Add advertisement from driver to userspace to indicate whether
RU puncturing is supported.
- Validate and configure the userspace specified RU puncturing bitmap
Changes are only compile-tested.

Aloka Dixit (3):
  nl80211: advertise RU puncturing support to userspace
  cfg80211: validate RU puncturing bitmap
  nl80211: validate RU puncturing bitmap

 include/net/cfg80211.h       | 18 ++++++-
 include/uapi/linux/nl80211.h | 32 ++++++++++++
 net/wireless/chan.c          | 99 ++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 71 ++++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 1 deletion(-)


base-commit: 8aaaf2f3af2ae212428f4db1af34214225f5cec3
prerequisite-patch-id: 328a8dc53fc4ed611094648f8354ea51a220a469
prerequisite-patch-id: 9f6778fe7023b0f4d103e206ed80cb3074c4e4f9
prerequisite-patch-id: 40aa2131e1529282c8099c4e270155292802f4ff
prerequisite-patch-id: c9db940e5649f3586357ee608d24f518a7fadb00
prerequisite-patch-id: edb4a64395858a174dd6ad739cf065f4092f2da1
prerequisite-patch-id: eeacae90f17719f5546e53cd04082849491dcfc2
prerequisite-patch-id: b5c0bb8119aa46b6aba653fa60c173c6546556e0
prerequisite-patch-id: 4a58f779c257d9191efe94a7283c59eff683f7c3
prerequisite-patch-id: fd4e44527c2965ae943c68c7c96bde33777bde59
prerequisite-patch-id: 6c8a84b6e8e3a5c317ec3410d9f99b06a779304d
prerequisite-patch-id: f7e51eb9ee4da52a5f79248f0314ef23db3333bc
prerequisite-patch-id: eb4c3cfd53903f093f233af6bf00b88acab86595
prerequisite-patch-id: 7d85d1f530c496da1ad6769c59f8524f58edfca9
prerequisite-patch-id: ff5183a0e028a1041700c32992eb18a13dc2de8b
prerequisite-patch-id: 159188202e4afc341f8a566d45cdf2e2afcb2d2e
prerequisite-patch-id: e69273ed8e6c0cebb8288230fc781f345663035d
prerequisite-patch-id: 06cfb4718beb6d69f078744feef1b6b897fad0aa
prerequisite-patch-id: d17f643739d565fca4d8f9139da0083d522647ed
prerequisite-patch-id: bb5917bb77a3de7b6804d25b56043ff26184d49d
-- 
2.31.1

