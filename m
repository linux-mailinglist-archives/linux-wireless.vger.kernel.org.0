Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F15A360B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 13:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfH3Lww (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 07:52:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22086 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726969AbfH3Lwv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 07:52:51 -0400
X-UUID: b30929717e024f3081883b6a934087ec-20190830
X-UUID: b30929717e024f3081883b6a934087ec-20190830
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 76994568; Fri, 30 Aug 2019 19:52:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Aug
 2019 19:52:45 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 19:52:45 +0800
Message-ID: <1567165961.8079.3.camel@mtkswgap22>
Subject: Re: [PATCH] mt76: mt7615: move mt7615 sta utilities in pci.c
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <linux-wireless@vger.kernel.org>, <royluo@google.com>
Date:   Fri, 30 Aug 2019 19:52:41 +0800
In-Reply-To: <e095a331854ab9c9619f86ae8860502abf808fbe.1567068930.git.lorenzo@kernel.org>
References: <e095a331854ab9c9619f86ae8860502abf808fbe.1567068930.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-29 at 10:57 +0200, Lorenzo Bianconi wrote:
> Move mt7615_sta_add, mt7615_sta_assoc, mt7615_sta_ps and mt7615_sta_remove
> utility routines in pci.c and make them static since they are only used to
> initialize mt76_driver_ops callbacks
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   |  4 --
>  .../net/wireless/mediatek/mt76/mt7615/main.c  | 40 ---------------
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 ---
>  .../net/wireless/mediatek/mt76/mt7615/pci.c   | 49 +++++++++++++++++++
>  4 files changed, 49 insertions(+), 51 deletions(-)

Just to note that we might have other interface shares with the same
utility routines in upcoming days.

Ryder

