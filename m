Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07D94673C7
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 10:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379473AbhLCJTa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 04:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379471AbhLCJT3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 04:19:29 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5496C06173E
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 01:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wcr8xiz3Z3wSW+G0UH4uCDfyjQuQs+rNnyYm250rd60=; b=oe1icz22eKLGQ6bD/VSd+baX+7
        p0MCqMQnpPhDqCAXTayVqs+fjPduL2bA8QXTQ+/vGsPhujETy+0U39eHPX/RwOAFbdX1gsZtHe6gz
        MCAGNivyjIMMgyolOEWqVEEQbntCNwoH3A0Z4aTxuPmnFcvdlXTdYV/nnBqv5Fq0xCT8=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mt4fk-0007dl-4P; Fri, 03 Dec 2021 10:16:04 +0100
Message-ID: <fc14e235-efce-514b-4f7e-8d83613eaffa@nbd.name>
Date:   Fri, 3 Dec 2021 10:16:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 04/11] mt76: mt7915: use nss for calculating rx-chains
Content-Language: en-US
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
References: <20211118164056.2965-1-greearb@candelatech.com>
 <20211118164056.2965-4-greearb@candelatech.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20211118164056.2965-4-greearb@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-18 17:40, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> When group-5 is enabled, we can find the actuall NSS used.
> In that case, update the rx chains info so that the upper
> stack can give better idea of actual antenna usage.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
I'm not sure this is correct. From my understanding, nss does not 
determine which antennas (and how many of them) are involved in 
receiving the signal.

- Felix
