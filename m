Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350F942C665
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhJMQb1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhJMQbY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 12:31:24 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFA5C061570
        for <linux-wireless@vger.kernel.org>; Wed, 13 Oct 2021 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mlfM8oa9U31hfMXaM65RvOi44aB/+9A6L1iUnZZ3ZTU=; b=dPZcXMu7exADgzHFL+Fc16TfRQ
        hxzij4CijQnaNlevD46C92byRMnD5t2FmOFNWnEmp0PCcHz9lxjhy7tOOn4wms/UfkRDKi99fcvFt
        lmFZOUM36z7h4fJHe2SDpV/tyRP4rBf5lAl6UXZgkEfsh3PcqhopqWuQmy0wzmHRnHb0=;
Received: from p4ff1322b.dip0.t-ipconnect.de ([79.241.50.43] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mah7y-0000pF-6L; Wed, 13 Oct 2021 18:29:14 +0200
Subject: Re: [PATCH v2] MAINTAINERS: mt76: update MTK folks
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <eb888ae0e43a980c2c1aaed372a9b5e8098ea4ef.1634107511.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <fee064c4-b4f8-d6d6-1e9d-397e4050d513@nbd.name>
Date:   Wed, 13 Oct 2021 18:29:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <eb888ae0e43a980c2c1aaed372a9b5e8098ea4ef.1634107511.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-13 17:56, Ryder Lee wrote:
> Add more MTK folks to actively maintain the wireless chipsets across
> segments. The work is becoming increasingly complicated and various
> and we can provides hardware related perspectives to offload 
> Felix's workload, especially for the 11ax and upcoming 11be devices
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Acked-by: Felix Fietkau <nbd@nbd.name>
