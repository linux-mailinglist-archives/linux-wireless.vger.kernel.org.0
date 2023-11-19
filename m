Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A0B7F0854
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Nov 2023 19:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjKSSYQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Nov 2023 13:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSSYP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Nov 2023 13:24:15 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA13C2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Nov 2023 10:24:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 813FB320097F;
        Sun, 19 Nov 2023 13:24:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 19 Nov 2023 13:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm2; t=1700418247; x=
        1700504647; bh=Ghajq2sXMlq4prW7btWmZuhNYsvMd0oxU8W4SfZ7+ZQ=; b=M
        +M5PC2P2UZyv6zJe1cbf5n/2yNwUw4CJH+tINbhzjwUesHIR3S4MlhftUF0iwJ6J
        BZsrExhIHhC48H9WjS/gMm3Da8U9z4ITM0ILjmd1QRYE87RO308G1HP5krrAvbBO
        k7BQTyW5Z5LRRaLyIT04otx8wuDG/n1WMGUwBegry0GgGrtI5PXRc+vt8SxfnXIh
        sbWCrp4WML9+P7Fwm/QvZE8HV+DWr/Prz0AbbjPCSNIB8D544wE7GDcmOc0UUXLh
        zNY63JIDeWMigJKoZsHNtjxZKXfczoFhiu21FLvXsrs/VxXccFpZQpilDqNnAkqg
        u2AvlCK5sth3FsE66z/bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1700418247; x=1700504647; bh=G
        hajq2sXMlq4prW7btWmZuhNYsvMd0oxU8W4SfZ7+ZQ=; b=kqcwojTivtIs1f0Bx
        0D67roxhxxQlTEohb1ivt+vOAgb2mqwXbBtIdcGA+dZ5DS9eWbT/gh4+wtU+icbV
        XcxOOZcZZYN61Rd3q9OmuePXgKuM0vJopeA+U//7hR4uPKHxOB+r5hjwA947ignb
        xzAavZ8MAyh+ahWBJrcRkELyy0YEM58mX3RBb04NarbHjExTWb11FYzCNdWQExXd
        +EQIH6aS3yH2Wxf16RsAE2sERPUqtinECSoNhcE3VDXyX93HLse0Z6c9LZCha67+
        cw3Lveyl4xyj4J3S036VwYn9z7v4d/SO4IcuBnsxX/Azhy4Mu9Yh5cHunu65Hw7d
        Fsx4g==
X-ME-Sender: <xms:xlJaZZ6n1No65l8Uc-YGzqhOstLoeh3xvbvR1VcZzp4EBtX5IoH89w>
    <xme:xlJaZW5uwQzQITRGoC8vGgQGtZ1-qCmgduATWHjcwBFWaDohjHRIh8ZvaFBmwAyEn
    bmm3LsEMAg6PnmtajY>
X-ME-Received: <xmr:xlJaZQcxW2ARAVArcUbjCPVrPu4q-63gTNwbes47b2Mpb5aPFdyO57EiYLb6uc9PTpofBFfgPOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeggedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtke
    ertdertdejnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdeuhfejveejueeije
    ejffevleefgeefjeffuddtfeeufeetkeetledvheekheegnecuffhomhgrihhnpehmihhi
    thdrghhovhdrtghnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:xlJaZSKWN36mVnKZ59-jLJYT9BU7U6xnAJwZI07iRED564CzDKkUYQ>
    <xmx:xlJaZdI8Kc7XAvnLUSu6h5cmUTK-d6FqYP9m96HZl9e23hY14u82HQ>
    <xmx:xlJaZbwtsoKwMQvCV_0PRMnaNvqYk6FG1K28wFvgebQ05Ounb3l08w>
    <xmx:x1JaZbiDqrfCRPL8XE4H8mYEkKmv4lGucknpYu1PTZ1kL5S22Wk83w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Nov 2023 13:24:06 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-wireless@vger.kernel.org
Cc:     wireless-regdb@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for China (CN)
Date:   Sun, 19 Nov 2023 18:24:01 +0000
Message-Id: <20231119182401.7630-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

China had updated regulations on 5150 MHz to 5350 MHz by
"中华人民共和国工业和信息化部令（第54号）", which released
an update to "中华人民共和国无线电频率划分规定".

The new regulation effectives from 1 July 2023.

In updated regulation, footnote "CHN44" had restricted 5150 MHz to
5350 MHz as in door only for Broadband Wireless Access systems.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 db.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index fdc2c13..24bb6d4 100644
--- a/db.txt
+++ b/db.txt
@@ -403,10 +403,11 @@ country CL: DFS-JP
 
 # Source:
 # https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219/d125301b13454551b698ff5afa49ca28.pdf
+# https://www.miit.gov.cn/cms_files/filemanager/1226211233/attach/20236/d1dc19424d5a4cfe90d631adeee8dd58.pdf
 # Note: The transmit power for 5150-5350MHz bands can be raised by 3dBm when TPC is implemented
 country CN: DFS-FCC
 	(2400 - 2483.5 @ 40), (20)
-	(5150 - 5350 @ 80), (20), DFS, AUTO-BW
+	(5150 - 5350 @ 80), (20), DFS, AUTO-BW, NO-OUTDOOR
 	(5725 - 5850 @ 80), (33)
 	# 60 GHz band channels 1,4: 28dBm, channels 2,3: 44dBm
 	# ref: http://www.miit.gov.cn/n11293472/n11505629/n11506593/n11960250/n11960606/n11960700/n12330791.files/n12330790.pdf
-- 
2.34.1

