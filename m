Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB60565590
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiGDMiH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 08:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiGDMiG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 08:38:06 -0400
X-Greylist: delayed 912 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 05:38:04 PDT
Received: from m1361.mail.163.com (m1361.mail.163.com [220.181.13.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C10FDEE6
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=x4CYc
        4QaPXM8z3++F9IQ3jq71sV942F7zDF1OLgiFyQ=; b=iL+1RFdi+ZSCqNJ9o29BT
        GjH0CL5ihVeCcBrpv84TM9pSKc7DTnVuEPCxyvBfUACeuWlbX+yLl6M4uep9xpVH
        0PdiFJeiPAIAF5cIsv3ABzS0K/FHkXtuYORVIuN64tHTocusjR2DKLy8GldUMtzs
        wzAldbJLUbcYfOLad/u468=
Received: from yxj790222$163.com ( [124.126.152.222] ) by
 ajax-webmail-wmsvr61 (Coremail) ; Mon, 4 Jul 2022 20:22:11 +0800 (CST)
X-Originating-IP: [124.126.152.222]
Date:   Mon, 4 Jul 2022 20:22:11 +0800 (CST)
From:   =?GBK?B?08jP/r3c?= <yxj790222@163.com>
To:     linux-wireless@vger.kernel.org
Subject: BUG: airo: could not associated with ap using wpa/tkip
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5ff79f86.53ed.181c9293ae3.Coremail.yxj790222@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: PcGowAAnTL1z28JiEZEZAA--.991W
X-CM-SenderInfo: 510mlmaqssjqqrwthudrp/1tbiQxo0vFc7acd9egABsV
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

CkkgZ290IGNpc2NvIGFpcm9uZXQgcGNtLTM0MCBkZWJpYW4gc2lkKExpbnV4IGRlYmlhbiA1LjE4
LjAtMi02ODYtcGFlICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgRGViaWFuIDUuMTguNS0xICgyMDIy
LTA2LTE2KSBpNjg2IEdOVS9MaW51eAopIHJlY29uaXNlZCBpdC4gQnV0IGl0IGNvdWxkIG5vdCBj
b25uZWN0IHdpdGggd3BhL3RraXAgYWNjZXNzIHBvaW50LgpkbWVzZzoKWyA5NzM2Ljg3MjcyM10g
YWlybyhldGgwKTogYXNzb2NpYXRpb24gZmFpbGVkIChyZWFzb246IDQwKQpbIDk3MzcuMDE2Nzkw
XSBhaXJvKGV0aDApOiBhc3NvY2lhdGlvbiBmYWlsZWQgKHJlYXNvbjogNDApClsgOTczOC4xNjM2
NDhdIGFpcm8oZXRoMCk6IGFzc29jaWF0aW9uIGZhaWxlZCAocmVhc29uOiA0MCkKWyA5NzQwLjA0
Mzc2NV0gYWlybyhldGgwKTogYXNzb2NpYXRpb24gZmFpbGVkIChyZWFzb246IDQwKQpbIDk3NDMu
MzQxNzQzXSBhaXJvKGV0aDApOiBjbWQ6MiBzdGF0dXM6ZmZmZiByc3AwOmZmZmYgcnNwMTpmZmZm
IHJzcDI6ZmZmZgpbIDk3NTEuNDU1MTQwXSBhaXJvKCk6IGNtZDoxMTEgc3RhdHVzOjdmMTEgcnNw
MDoyIHJzcDE6MCByc3AyOjAKWyA5NzUxLjQ1NTE1OF0gYWlybygpOiBEb2luZyBmYXN0IGJhcF9y
ZWFkcwpbIDk3NTEuNDY0OTg0XSBhaXJvKGV0aDApOiBGaXJtd2FyZSB2ZXJzaW9uIDUuMzAuMTcK
WyA5NzUxLjQ2NDk5NF0gYWlybyhldGgwKTogV1BBIHN1cHBvcnRlZC4KWyA5NzUxLjQ2NDk5Nl0g
YWlybyhldGgwKTogTUFDIGVuYWJsZWQgMDA6NDA6OTY6MzE6Nzk6N2UKWyA5NzUxLjYwMjE5M10g
YWlybyhldGgwKTogQmFkIE1BQyBlbmFibGUgcmVhc29uPWNmMDksIHJpZD0zOTQ4LCBvZmZzZXQ9
NjIzNzgKWyA5NzUxLjYyNjQ4OV0gYWlybyhldGgwKTogQmFkIE1BQyBlbmFibGUgcmVhc29uPWNm
MDksIHJpZD0zOTQ4LCBvZmZzZXQ9NjIzNzgKCg==
