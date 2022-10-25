Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77E060C0DF
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 03:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiJYBUn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Oct 2022 21:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiJYBT7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Oct 2022 21:19:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4346229
        for <linux-wireless@vger.kernel.org>; Mon, 24 Oct 2022 17:45:03 -0700 (PDT)
X-UUID: 9f74efae27154d9d8174044a6893f9ad-20221025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=axatU4fcD+wolPyz4bGrdQ9wRDjsPIVraTvvyidQSxU=;
        b=IxerMc4MBbQIlHH8erRikzj/KxIGLNEao/siRzqL3hnR6iSaxmc8yviZcCdCeNFuBaPyrBbdGyHChT61cqNL3ahMuIIh2NM/j40MWYPVplsWyam3ddekEyMrH21cn3psAaAfVPvYtVxU2HoRJJuAvNQm4cJLb7O0905CAoK5EOQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:e938d554-0014-419e-864d-1089159c13f3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.12,REQID:e938d554-0014-419e-864d-1089159c13f3,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:62cd327,CLOUDID:198588e4-e572-4957-be22-d8f73f3158f9,B
        ulkID:221025084459R6K0WYCR,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0
X-UUID: 9f74efae27154d9d8174044a6893f9ad-20221025
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1056121580; Tue, 25 Oct 2022 08:44:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 25 Oct 2022 08:44:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 25 Oct 2022 08:44:57 +0800
Message-ID: <42da87e3aa229722fac9566aaef963acd28d9c7a.camel@mediatek.com>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7915: enable use_cts_prot support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 25 Oct 2022 08:44:57 +0800
In-Reply-To: <f13c8c4ae61eb1374ca65e92b03e908c21073917.1666657715.git.ryder.lee@mediatek.com>
References: <f13c8c4ae61eb1374ca65e92b03e908c21073917.1666657715.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-10-25 at 08:31 +0800, Ryder Lee wrote:
> This adds selectable RTC/CTS enablement for each interface.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Change-Id: I5eb7851b513d4140d879676154e2abe769969c01
> ---

Oops. I accidentally included our internal change-id for both patch.

@Felix, can you help to drop them while merging?

Ryder

