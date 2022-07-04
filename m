Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1F5656A1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiGDNK6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 09:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiGDNK4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 09:10:56 -0400
Received: from m1361.mail.163.com (m1361.mail.163.com [220.181.13.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16A8C62F8
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=p71hK
        11nJ5Yprbx6JgOb+Nmn62MlL3K+5bb3LphyCIY=; b=IIoXQGmsCepviSiinqWwH
        Cc5L4KtS+Lqjl+7QfWHzAzKTXet/szdOnIU/cP1vMTU9nmKZXxXYCRbbA5XZoQ/L
        l9CcuJqjVyiFVrxhL/qioIPPY5wj3MPDud40+BCof+aTpJ0ccNWW/ehrx5VH3nae
        b0lbFwAHpWOXNtpEeGu0EM=
Received: from yxj790222$163.com ( [124.126.152.222] ) by
 ajax-webmail-wmsvr61 (Coremail) ; Mon, 4 Jul 2022 20:54:36 +0800 (CST)
X-Originating-IP: [124.126.152.222]
Date:   Mon, 4 Jul 2022 20:54:36 +0800 (CST)
From:   =?GBK?B?08jP/r3c?= <yxj790222@163.com>
To:     linux-wireless@vger.kernel.org
Subject: BUG: b43: ssb init failed with pcmcia bus
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <107e64a6.54f2.181c946ea99.Coremail.yxj790222@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: PcGowACXvL0M48Jid5IZAA--.1493W
X-CM-SenderInfo: 510mlmaqssjqqrwthudrp/1tbiQxY0vFc7acgOgwABsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

CkkgZ290IDgwMi4xMWIgY2FyZCBkZWJpYW4gc2lkKExpbnV4IGRlYmlhbiA1LjE4LjAtMi02ODYt
cGFlICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgRGViaWFuIDUuMTguNS0xICgyMDIyLTA2LTE2KSBp
Njg2IEdOVS9MaW51eAopIHJlY29uaXNlZCBpdC4gQnV0IHNzYiBjb3VsZCBub3QgYmUgcmVjb25p
c2VkCmRtZXNnOgpbIDEyNjguMDI5MTEzXSBwY21jaWFfc29ja2V0IHBjbWNpYV9zb2NrZXQwOiBw
Y2NhcmQ6IFBDTUNJQSBjYXJkIGluc2VydGVkIGludG8gc2xvdCAwClsgMTI2OC4wMjk2NDZdIHBj
bWNpYSAwLjA6IHBjbWNpYTogcmVnaXN0ZXJpbmcgbmV3IGRldmljZSBwY21jaWEwLjAgKElSUTog
MjEpClsgMTI2OC4xMTcxODZdIHNzYjogRmFpbGVkIHRvIHN3aXRjaCB0byBjb3JlIDAKWyAxMjY4
LjExNzIyNV0gc3NiLXBjbWNpYSAwLjA6IEluaXRpYWxpemF0aW9uIGZhaWxlZCAoMCwgLTE2KQpb
IDEyNjguMTE3MjMyXSBzc2ItcGNtY2lhOiBwcm9iZSBvZiAwLjAgZmFpbGVkIHdpdGggZXJyb3Ig
LTE2CmFsbGFuQGRlYmlhbjp+JCAK
