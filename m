Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD442A158
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 11:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhJLJrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbhJLJrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 05:47:10 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CFBC061570
        for <linux-wireless@vger.kernel.org>; Tue, 12 Oct 2021 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=65RWB032W8M+cqEQt5P+co8pnWM1dAOEoMjrB9AG3p4=; b=cCYyk3jegRpVbQUcEyLeDFVyB2
        hZwXMKVlZJxPu9PD9OQx/6P6JPKo5SZNTcKvLs86Esh4El2D1VwqNmAipO4O/ne/24vUzmCY9Fj1H
        ZCS66FxjyPS1E+/rf4NFntJHaI9toGDh7nd9iuobKN8pBFRl+P1l8m/OwzuIRsMC4v1c=;
Received: from p4ff1322b.dip0.t-ipconnect.de ([79.241.50.43] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1maELK-0005SR-Vx; Tue, 12 Oct 2021 11:45:07 +0200
Subject: Re: [PATCH] mt76: mt7915: add debugging for MCU command timeouts.
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
References: <20211011205406.23485-1-greearb@candelatech.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <aad5ddb8-97a5-4f65-f817-7daa36cca5a7@nbd.name>
Date:   Tue, 12 Oct 2021 11:45:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211011205406.23485-1-greearb@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-10-11 22:54, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Print information about whether the message is the first timeout,
> and also print info if we manage to recover after a timeout.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
> 
> NOTE:  Not sure this is really something folks would want upstream, but
> maybe it helps someone else trying to debug this driver.
I think it would be much more useful to add tracepoints for tx/rx mcu
messages.

- Felix
