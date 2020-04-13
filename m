Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C3A1A632F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2020 08:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgDMGsf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Apr 2020 02:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbgDMGsf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Apr 2020 02:48:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF91C008651
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 23:48:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w11so4066850pga.12
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2020 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V8FxIiIa/TXjm9S7utiVILgjnG/f48VqNhX4GcVaXLg=;
        b=Ce1jEqSlokrDGvunDyR9bUnACrg2o9q4WoKw8vdKFYCfyg3g/5USrGD1A77hxvB1HP
         omJmvefIBSa96+MPVFLzPjA/AGPrg8Bnt8bUgcveM4nSd6x/S2VF0GdiurQNp1yXH550
         tGtDnDiBrpntUr1J9Ex2Qg+5wpzzgr+RsDibI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V8FxIiIa/TXjm9S7utiVILgjnG/f48VqNhX4GcVaXLg=;
        b=CBYBgqBRag5+iIiCTUxIkI5aT5SBb3/VyKFuain7uO2WypL13rWQ632/fq70hvxg65
         cKw0pknCiDr/fwjk3ZAsboktMYy2Jx46oQcX87OXZLGYrW1jgO86xLjyNlP14RsrJM59
         Rsh98gGpk9d9qDOMpVRoVIl3j32VvnTqPHWSEuBvE8WbERfqED0p0pTZWjDhFtaQL4Qq
         PaSBz54lkXholwruO8PBKWAYco1tNibXiU5hwTrD/AXGhp8JOsc0YhsO31tojP1wiwTk
         tAQloUAUdkTGWPE3MTvnqY1ZdtBxQs+xwOCm4btSdL1RCDC1Z9LrFCDnWyyu6Yw+H2Yz
         44pA==
X-Gm-Message-State: AGi0Pub7LV84njA+ge52pNqIUgCHvOWiCbT06GF3Lq4TvfVhqtMge35H
        HJsyqDCLnADMi6WWRodQXD8FCUMwcB49h7MF
X-Google-Smtp-Source: APiQypIuKwXBc5IZrT2akRd5a0qulCuzNCYzkFYFYfzP9gKlFYaVdqhzy5UfOrYjYn0oPZPPu1K6ew==
X-Received: by 2002:a62:164a:: with SMTP id 71mr15651380pfw.273.1586760514160;
        Sun, 12 Apr 2020 23:48:34 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id y126sm2703268pgy.91.2020.04.12.23.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 23:48:33 -0700 (PDT)
Subject: Re: [PATCH] mt76: replace consume_skb with dev_kfree_skb
To:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc:     ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <b90644567e758b5702e37e34e31f2007e3bd2c87.1586290996.git.sean.wang@mediatek.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <b1038177-4ed0-93fe-a093-a9278412dfd8@broadcom.com>
Date:   Mon, 13 Apr 2020 08:48:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b90644567e758b5702e37e34e31f2007e3bd2c87.1586290996.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/7/2020 10:25 PM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> consume_skb is identical to dev_kfree_skb, so that replace consume_skb with
> dev_kfree_skb just to make consistent in whole mt76 driver.

Given that dev_kfree_skb is a define that maps it to consume_skb I would 
say the use of consume_skb() is preferred. So maybe better to get 
consistency in the driver by replacing dev_kfree_skb with consume_skb.

Regards,
Arend
