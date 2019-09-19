Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2647B804F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 19:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391044AbfISRol (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 13:44:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45548 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391042AbfISRok (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 13:44:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id 4so2274048pgm.12
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KV7BcvVoIG2Uqk9r+7/9f3w5prQhME9V1LLUutRolBE=;
        b=uZHjeIj/sglu3+IuPenK9IEHeEBP81Q4z+qBPBqMuKlP+1l9koWIJYZVF9q01mV3sI
         y8sP4C6YroshRsQOq2ryYGn1R2Yp6hIL1ApB/i+9eI8ANaJqn1fTQ0oUBFeMAXTzS0iN
         3rVPCn4MJWWXYaPs/qK/NCMr5za6VKXNr8wjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KV7BcvVoIG2Uqk9r+7/9f3w5prQhME9V1LLUutRolBE=;
        b=n0Gdy0ZEIs2gNGoO2p40PZrsZaxfq6/LCYqJOwJsyHh2/NYkkxmJoav3U7P14oveIm
         lUX5oN2PGmiVHP9NUmyjtkUjdlRF6xutWf3joXLwlrmHHecjFA5LiG8eNHc3OT2ysC1g
         n1u+OH2m43fD8TtelovT94lhnJCyoh0vuQMwJ8NeDLKF/63cb/kJ8eQcQlOKGHxE1Bfb
         BEltFthOf8+eL6CxHkwPJi3qgeooPFii3dbIx8YTUCTpo3R6GewF2Moef63mGlAnzb/W
         mxB1kCPULSbva9PsPUsqUUQ/t5vcWx2t7K2ebGSZCzz0xleOXbswDcDPJZUadfFuAqC5
         zuxw==
X-Gm-Message-State: APjAAAVHlGq93DMbtdNI3qcglpsZGIVjtc5s9Ju4ubNTRdmKAQFkaZ3Z
        EuMq6VPycJanHgRbJAaaaxXlNA==
X-Google-Smtp-Source: APXvYqz2KQhgCTfkrUM5ZHfxzNO49be/EC1oFfZEpGvfuCcBOrDdMdeuR3+saQ19c/jHQQE10YDuhQ==
X-Received: by 2002:a65:6084:: with SMTP id t4mr10497447pgu.248.1568915078451;
        Thu, 19 Sep 2019 10:44:38 -0700 (PDT)
Received: from [10.0.2.15] (eero.static.monkeybrains.net. [199.116.72.162])
        by smtp.gmail.com with ESMTPSA id f62sm17760523pfg.74.2019.09.19.10.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:44:37 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit
 (AQL) on packet dequeue
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <f21b10fd-02ae-af59-8e2f-88f654627ab3@eero.com>
Date:   Thu, 19 Sep 2019 10:44:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156889576869.191202.510507546538322707.stgit@alrua-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/19/19 5:22 AM, Toke Høiland-Jørgensen wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
>
> This patch ports that idea over to mac80211. The basic idea is simple
> enough: Whenever we dequeue a packet from the TXQs and send it to the
> driver, we estimate its airtime usage, based on the last recorded TX rate
> of the station that packet is destined for.

The way to decide the last recorded TX rate could be vary among drivers. 
In terms of ath10k driver and FW, they use 4 PPDUs to update the Tx 
rate. Isn't it too small sampling number to be used for AQL?

Peter

