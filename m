Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DB22559FC
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 14:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgH1MX7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 08:23:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55172 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbgH1MXy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 08:23:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598617434; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BEqM9FU515T0rTU5P4IpqycDzG9iwNCYRf5BIFd8Fyc=;
 b=mDDexsNTXmZppJNHfhJIQTwNj/MsOlhEOir88ppmNIXh9axuZhIITaKzIuOomyfTa9NgQ6B0
 ar0NXBqjIJSaORuWh5lK3SoPCrpBLyI34Ybswnr+MDkj18yYMaYUdBc0Q7NBvvCNVeGoPnri
 NFr4n0nIDlDMS4f4XZ+Q3T9vmRU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f48f75af4f3e6461369dced (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 12:23:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C474C433CA; Fri, 28 Aug 2020 12:23:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03D79C433C6;
        Fri, 28 Aug 2020 12:23:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Aug 2020 20:23:52 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath10k: add flag to protect napi operation to avoid
 dead loop hang for SDIO
In-Reply-To: <CABPxzYJ982LdcUD3a_tyu3rrqp+iacZrmAp4zG_3HqCiDCR_2w@mail.gmail.com>
References: <1598243612-4627-1-git-send-email-wgong@codeaurora.org>
 <CABPxzYLjys+cXXRM5J680ZOs+6VrYt=_3rWv-gqkCod=-A1VrA@mail.gmail.com>
 <fd98989a87f2a50655dc95bdcd535c0d@codeaurora.org>
 <CABPxzYKvPwtQwxMfRcv9jT+d92ErhYGR91SKBH86T3Rd2QH9Qg@mail.gmail.com>
 <2d6362ce85956d0f7df2e596b89a7028@codeaurora.org>
 <CABPxzY+Fc22ke1ygRnDs0Uds0a7n=792QN8ALXciDrnx9SQuqQ@mail.gmail.com>
 <663fbb682fd8df555b2964d7d86b8eca@codeaurora.org>
 <CABPxzYJ982LdcUD3a_tyu3rrqp+iacZrmAp4zG_3HqCiDCR_2w@mail.gmail.com>
Message-ID: <37ae0f512cb677128fbb613e4b64d4c0@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-25 16:24, Krishna Chaitanya wrote:
v3 sent: https://patchwork.kernel.org/patch/11742675/
