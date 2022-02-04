Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5214A9BD6
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359641AbiBDPTz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 10:19:55 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:53701 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359642AbiBDPTx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 10:19:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 83C4A32020C9;
        Fri,  4 Feb 2022 10:19:52 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Fri, 04 Feb 2022 10:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=OgU2VHGC0hT47LbeDTqJjHF9cJjuXmPUrZw//u
        DBbE4=; b=Vh68+mmL/Xd1olF9qI2kZVf9Q2BSpXc3yk3QJCMNB0N+N13TaUqBBa
        6AcnUcUYuRe/D+75f6f18t287+3Pe1uD27wE8m1AJShDlXZx6n/WBYdKHJQ8j43I
        ogBOjN7VY5Une+dUHv2DoRmiZaVagmu3U7nIS/qghR0UoT9lGRBwsdYEP3CJmMjm
        MtybkiWmeRkNtnUNZz0RcH5iRUB/f80N4zCalE+CF3ZY/7ioMkajyAEP8H7e3oLK
        z5+AObNadkSZOZ9z3XXpTq43QOkJjXGg4OowB07MY2EUEf3156+EAZeEXRE/Nr4w
        1fFrVlkJ5jsQ0axL3YGE4c3KX87h+V1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=OgU2VH
        GC0hT47LbeDTqJjHF9cJjuXmPUrZw//uDBbE4=; b=AR64hYfgNwfppr+uzGyq30
        aFePuN3vg3P2P1GDaFbyslS04rXlUyp9C2VebVgV8zxW8HuX7gj2DxBmQLDEyyiy
        bO9p43NUh5j+/lAxBFGqGr9NtJgVGfOECY7QnMPNaH4VogdlORUkUeDoYasxvbwM
        4TwPB6OsrSzU1EmLBZUCBsbulUba0KauYHrxXF3/TFGZLFlGdNQXryCQvrIc4Xfo
        0DpjxCEkmaHVUJI/5TlETPiDDsxe/fuYvBpPW9VCuXiZnMwRjDcJ/cph8sFUZ5Up
        bLBS8Y42s3EO8y8ORPovNw/HdkpLMmGOGfhpa5QmGRLa6N78kZ2Ieb72AOrcdyPA
        ==
X-ME-Sender: <xms:F0T9YTXG8V_qqY023PFwexLdVPicDzhtzMDWzCEKJ4OzKBK_Q4j66A>
    <xme:F0T9Ybke1wjwipbozhZ5IesDBYaP52nxS8fV2LVHM3vtB_E7ofLAEIMWT-90d2uto
    cvY7nTnbWERsfxgdYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeelgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgfgsehtqhertd
    erreejnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepudfhveeiveethedugf
    ejfedtfeeltdetjeefjeffgeeludfghfdvveejkeejieeunecuffhomhgrihhnpehmihhi
    thdrghhovhdrtghnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:F0T9YfaiHsEL1zSRwKfLamHXmSeOci26Af_4Bi_0w4v4VwlPzFF-WQ>
    <xmx:F0T9YeXSH5SLQ7ZboQOX3-eBlvb6jwCMMeVyj2KeVW53aJqry8PsmA>
    <xmx:F0T9YdlNZubK-n8-qozX18aw_iDG1N6nIMKMzznuEctd7B8Lvyn07w>
    <xmx:GET9YcvoBGyuV8zzsZgVACf8IEFnbib4-L0AYxQSNwzow8fcd_kUKA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B60F9FA0AA6; Fri,  4 Feb 2022 10:19:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4586-g104bd556f9-fm-20220203.002-g104bd556
Mime-Version: 1.0
Message-Id: <9a460b85-4e1b-40b2-8691-3f999331c76b@www.fastmail.com>
Date:   Fri, 04 Feb 2022 15:19:29 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: Update regulatory rules for China (CN)
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

China had updated regulations on ISM frequencies by
"=E5=B7=A5=E4=BF=A1=E9=83=A8=E6=97=A0=E3=80=942021=E3=80=95129=E5=8F=B7".

The new regulation effectives from Jan 1 2022.

Update regdb accroading to it's attachment "2400MHz=E3=80=815100MHz
=E5=92=8C 5800MHz =E9=A2=91=E6=AE=B5=E6=97=A0=E7=BA=BF=E7=94=B5=E5=8F=91=
=E5=B0=84=E8=AE=BE=E5=A4=87=E5=B0=84=E9=A2=91=E6=8A=80=E6=9C=AF=E8=A6=81=
=E6=B1=82".

Announcement: https://wap.miit.gov.cn/zwgk/zcwj/wjfb/tz/art/2021/art_e4a=
e71252eab42928daf0ea620976e4e.html
Attachment: https://wap.miit.gov.cn/cms_files/filemanager/1226211233/att=
ach/20219/d125301b13454551b698ff5afa49ca28.pdf

Those documents are only available in Chinese.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 db.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/db.txt b/db.txt
index 6dbda3c..e6fd657 100644
--- a/db.txt
+++ b/db.txt
@@ -346,11 +346,12 @@ country CL: DFS-JP
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5735 - 5835 @ 80), (20)
=20
+# Source:
+# https://wap.miit.gov.cn/cms_files/filemanager/1226211233/attach/20219=
/d125301b13454551b698ff5afa49ca28.pdf
 country CN: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (23), AUTO-BW
-	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
-	(5735 - 5835 @ 80), (30)
+	(2400 - 2483.5 @ 40), (20)
+	(5150 - 5350 @ 80), (23), DFS, AUTO-BW
+	(5725 - 5850 @ 80), (33)
 	# 60 GHz band channels 1,4: 28dBm, channels 2,3: 44dBm
 	# ref: http://www.miit.gov.cn/n11293472/n11505629/n11506593/n11960250/=
n11960606/n11960700/n12330791.files/n12330790.pdf
 	(57240 - 59400 @ 2160), (28)
--=20
2.34.1.windows.1
