Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDCD599AE9
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348736AbiHSLYr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 07:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347755AbiHSLYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 07:24:45 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D159D83FA;
        Fri, 19 Aug 2022 04:24:43 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JAsD1v010923;
        Fri, 19 Aug 2022 04:22:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=PPS06212021;
 bh=Su2HVFgvTJxzBAs/OFLrnCjt6Crc0zTGaGOL7vxEij8=;
 b=OUWgWekcRu1/1JjdCCqlF26nICPKy/QDsUwBnMaJ4+QoiCxauqkeyUoOJBKzOcSzz5EB
 mvdHvco4ETXa/awPAO3U9gmi6AwePfjT2s4L5BYBBGUI/6E34+U+6TYQKG0Qbj7B3JtL
 +RykCSJAtfBCzavVn1b2j8yqTlGnwGqICiNT6uecdCzudaMP+9W4vJYXndPfDaVkdgD3
 ZslHdeDNLKwM3IAP8ODqlRV8M5iUtMzg8OdY89Tus7XJtb4kcfwvkjcpklnfsnK/xVA6
 sRMbaFQ4bMFIKUXS2PHzygB8DdhPIT+SbumVtK+rt/eXPJIF0LKm2SA2Rj9vpB9iiI2W lQ== 
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hx783d654-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Aug 2022 04:22:09 -0700
Received: from otp-dpanait-l2.corp.ad.wrs.com (128.224.125.191) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 19 Aug 2022 04:22:05 -0700
From:   Dragos-Marian Panait <dragos.panait@windriver.com>
To:     <stable@vger.kernel.org>
CC:     Pavel Skripkin <paskripkin@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vasanthakumar Thiagarajan <vasanth@atheros.com>,
        Sujith <Sujith.Manoharan@atheros.com>,
        Senthil Balasubramanian <senthilkumar@atheros.com>,
        "John W . Linville" <linville@tuxdriver.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4.19 0/1] ath9k: fix use-after-free in ath9k_hif_usb_rx_cb
Date:   Fri, 19 Aug 2022 14:21:55 +0300
Message-ID: <20220819112156.922376-1-dragos.panait@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [128.224.125.191]
X-ClientProxiedBy: ala-exchng01.corp.ad.wrs.com (147.11.82.252) To
 ala-exchng01.corp.ad.wrs.com (147.11.82.252)
X-Proofpoint-ORIG-GUID: nDd6ne6xFrp3whYuSGD_MAj7xBkvdMsK
X-Proofpoint-GUID: nDd6ne6xFrp3whYuSGD_MAj7xBkvdMsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_06,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=307 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following commit is needed to fix CVE-2022-1679:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0ac4827f78c7ffe8eef074bc010e7e34bc22f533

Pavel Skripkin (1):
  ath9k: fix use-after-free in ath9k_hif_usb_rx_cb

 drivers/net/wireless/ath/ath9k/htc.h          | 10 +++++-----
 drivers/net/wireless/ath/ath9k/htc_drv_init.c |  3 ++-
 2 files changed, 7 insertions(+), 6 deletions(-)


base-commit: 5c7ccbe1aade74e854fb7f9fa001dc1110a0030e
-- 
2.37.1

