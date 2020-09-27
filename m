Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357F227A1C3
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgI0QJd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0QJc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 12:09:32 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93956C0613CE
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mUtQDppDfybGiF1va3WDoaBNTHi/Nun7+tQtSObbvjs=; b=aloRUmVgpPgOedpnxGuKl037sz
        LWaI8fExoFnx0MEz8Ms1+0dcOFP8BtYxT7wYk7SGWH6nE4ETpHfk4/xayBRuL17Ss79P9o0Ue28Kq
        G0ydlFHGWcbF06qen4DdiH5WO7kYXbiZR50Y8htmDCnwsaJMwgk5148mZShoVQY+KUF0=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kMZEm-0006VQ-GH; Sun, 27 Sep 2020 18:09:20 +0200
Subject: Re: [PATCH] mt76: mt7615: enable beacon filtering by default for
 offload fw
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
References: <bfe45686ca8d8b5db2b27e33859bea7450f7b920.1601133687.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <a4e15f9f-a296-f862-6216-ed3b40423aa7@nbd.name>
Date:   Sun, 27 Sep 2020 18:09:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <bfe45686ca8d8b5db2b27e33859bea7450f7b920.1601133687.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-26 17:22, Lorenzo Bianconi wrote:
> In order to reduce cpu cycles, enable hw beacon filter by default if the
> device is running offload fw
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
The beacon filtering part and runtime pm needs to take into account that
there could be more than one vif and we might be running an AP as well.

- Felix
