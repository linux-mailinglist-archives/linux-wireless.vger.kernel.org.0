Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28A2FEEFE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jan 2021 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbhAUPgR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jan 2021 10:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733064AbhAUPeH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jan 2021 10:34:07 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08390C06178C
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jan 2021 07:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ju2SmmgkK5aZ5WHO96w4XS7/Y1iCqxYUhB8gr5O1LFY=; b=qICfrgA57SLwOmNfza3MiSDLdw
        i3S/9E8z0bHj1EN7z3IZDIrPVQfvFX2dvK3gDQ+TJ27MlkJ/Ns4bfTIESz8k0g5/qt0tYWzH21dzj
        zJWsDslCljxQ3goiYHsfywiwcxhIOsAPkpRi02BO6BAplqej3qTiDJSDfiSJdjaFHcTc=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l2bxb-0007JU-GK
        for linux-wireless@vger.kernel.org; Thu, 21 Jan 2021 16:33:23 +0100
Subject: Re: [PATCH 2/3] mt76: mt7915: fix vif sta index for DBDC
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
References: <20210119164943.99223-1-nbd@nbd.name>
 <20210119164943.99223-2-nbd@nbd.name>
Message-ID: <9154b852-e85c-8ecd-b02d-7c4d9eff7add@nbd.name>
Date:   Thu, 21 Jan 2021 16:33:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119164943.99223-2-nbd@nbd.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-01-19 17:49, Felix Fietkau wrote:
> Since vif indexes are per-phy, we need to factor in the phy index to avoid
> collisions on the WTBL index
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
This one is superseded by
"mt76: mt7915: make vif index per adapter instead of per band"

- Felix
