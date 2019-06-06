Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C1377AB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfFFPSe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 11:18:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51237 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729015AbfFFPSd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 11:18:33 -0400
X-UUID: 5fb22adf88d34f0fb2e5dba7a463049b-20190606
X-UUID: 5fb22adf88d34f0fb2e5dba7a463049b-20190606
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 972181061; Thu, 06 Jun 2019 23:18:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 6 Jun 2019 23:18:22 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 6 Jun 2019 23:18:22 +0800
Message-ID: <1559834302.3339.1.camel@mtkswgap22>
Subject: Re: [PATCH v3 1/2] mt76: mt7615: enable support for mesh
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 6 Jun 2019 23:18:22 +0800
In-Reply-To: <a0a6f631-2eb1-87cc-5653-338c6126690c@newmedia-net.de>
References: <a1ff446dfc06e2443552e7ec2d754099aacce7df.1559541944.git.ryder.lee@mediatek.com>
         <a0a6f631-2eb1-87cc-5653-338c6126690c@newmedia-net.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-06-06 at 12:14 +0200, Sebastian Gottschall wrote:
> in addition you should take care about this problem which is raised up 
> if SAE is used. since AES-CMAC required tid to be non zero
> 
> WARNING: CPU: 2 PID: 15324 at 
> /home/seg/DEV/mt7621/src/router/private/compat-wireless-2017-09-03/net/mac80211/key.c:1096 
> mt76_wcid_key_setup+0x58/0x9c [mt76]
> Modules linked in: shortcut_fe gcm ghash_generic ctr gf128mul mt7615e 
> mt76 mac80211 compat
> CPU: 2 PID: 15324 Comm: wpa_supplicant Tainted: G        W 4.14.123 #106
> Stack : 00000000 87c2d000 00000000 8007d8b4 80480000 80482b9c 80610000 
> 805a4390
>          8057e2b4 854fb99c 87ed045c 805e4767 80578288 00000001 854fb940 
> 805e9f78
>          00000000 00000000 80640000 00000000 81147bb8 00000584 00000007 
> 00000000
>          00000000 80650000 80650000 20202020 80000000 00000000 80610000 
> 872b9fe0
>          872a2b14 00000448 00000000 87c2d000 00000010 8022d660 00000008 
> 80640008
>          ...
> Call Trace:
> [<800153e0>] show_stack+0x58/0x100
> [<8042e83c>] dump_stack+0x9c/0xe0
> [<800349f0>] __warn+0xe4/0x144
> [<8003468c>] warn_slowpath_null+0x1c/0x30
> [<872b9fe0>] mt76_wcid_key_setup+0x58/0x9c [mt76]
> [<87611690>] mt7615_eeprom_init+0x7b4/0xe9c [mt7615e]
> ---[ end trace e24aeb4b542e0dea ]---

This is fixed by Lorenzo's patch -
https://patchwork.kernel.org/patch/10976191/

Thanks.
Ryder

