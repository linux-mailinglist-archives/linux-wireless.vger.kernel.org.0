Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFE439403B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhE1JmS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhE1JmR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 05:42:17 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12620C061574
        for <linux-wireless@vger.kernel.org>; Fri, 28 May 2021 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AGxydUEVGkGqs2EIlKkeL7LUv/JG8FJNDYvBsZSrsIk=; b=JugwPPzjAamPu8GMHLAcz76csp
        1IoDXxkh69tVcZa1m6kv8yi3ydkDiOrtfC/Hxw8EgNO+3BQEHt1D88c7+9JqUwlXWybwj1nskoPR7
        2caQEXhRUZR4uJYsrEB2NZU+h8+dqn44DoHFJMd3H0Y7DAyI5kJ/zGHrVHpoJHx5nMno=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lmYyt-0006HP-VT; Fri, 28 May 2021 11:40:40 +0200
Subject: Re: [PATCH] mt76: move interface_modes configuration in hw specific
 code
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
References: <2b1f297ab8fd61241d86ff18f9c1ca634289c3f2.1621582373.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <a3039b37-e41f-dc13-c719-2958324bc98d@nbd.name>
Date:   Fri, 28 May 2021 11:40:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2b1f297ab8fd61241d86ff18f9c1ca634289c3f2.1621582373.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-05-21 09:35, Lorenzo Bianconi wrote:
> Move wiphy interface_modes configuration in hw specific code since some
> drivers (e.g. mt7921) do not support all operating modes (mt7921 supports
> sta only in the current codebase)
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
I'd prefer moving it to mt76_alloc_device and mt76_alloc_phy, which
allows the driver to override it.

- Felix
