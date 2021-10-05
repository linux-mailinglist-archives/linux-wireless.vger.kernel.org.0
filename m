Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45051423345
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 00:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbhJEWL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 18:11:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:32747 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236861AbhJEWL4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 18:11:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633471805; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: Sender; bh=TDiIAapy1mALvPm4QN1EqMx9ZaY3yYYOg48UXWo2LG0=; b=W3PMYZEwNBgNUmEY4SlHCtnMca9UXXCXF273ZorsvSv6IwDvQYr7O84qGRrfaEwsR+I7IfOr
 EBk2JHqREEhXTB0JJLJGHBjmE3kB8JBwKiI8/jhe6xOUKWXeL3yZm5XqpCtG7JGn9yWsmXxs
 98tDP8fCDnW6Zg1VxrXDb+HUWEY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 615ccd3b003e680efbea3e84 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 22:10:03
 GMT
Sender: jjohnson=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB894C43617; Tue,  5 Oct 2021 22:10:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.135] (c-24-4-33-213.hsd1.ca.comcast.net [24.4.33.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jjohnson)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6144CC4360C;
        Tue,  5 Oct 2021 22:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6144CC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Message-ID: <c051f7f8-132c-59dd-717d-11d590ddecb0@codeaurora.org>
Date:   Tue, 5 Oct 2021 15:09:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] [v18 2/2] wireless: Initial driver submission for
 pureLiFi STA devices
Content-Language: en-US
To:     Srinivasan Raju <srini.raju@purelifi.com>
Cc:     mostafa.afgani@purelifi.com, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
References: <20200928102008.32568-1-srini.raju@purelifi.com>
 <20211005123230.13813-1-srini.raju@purelifi.com>
From:   Jeff Johnson <jjohnson@codeaurora.org>
In-Reply-To: <20211005123230.13813-1-srini.raju@purelifi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/5/2021 5:31 AM, Srinivasan Raju wrote:> +		fw_data = 
kmemdup(&fw->data[fw_data_i], blk_tran_len,> +				  GFP_KERNEL);> +> +	 
for (tbuf_idx = 0; tbuf_idx < blk_tran_len; tbuf_idx++) {> +			/* u8 bit 
reverse */> +			fw_data[tbuf_idx] = bitrev8(fw_data[tbuf_idx]);> +		}
note kmemdup() can return NULL, hence the reference to fw_data[] can 
dereference NULL.
