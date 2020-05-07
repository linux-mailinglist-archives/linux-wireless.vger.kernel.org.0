Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045B21C9CC8
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 22:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGUzO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 16:55:14 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15960 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgEGUzO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 16:55:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588884914; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3xIfW2AU3J3r/H9xQJs2hT0UbPGNez6Lr+kdeQSCAm8=;
 b=fUnrPYDUciyrUQyn4QznyXG1ez5Osqvb0WEsh673wKIkHsdJSb3ZAXkwl9vFBr4cxk01FbCJ
 nArWhWQQEyn3HutjV8p2HQ71qIoY1Ec1uTZET3vY8RzcVBPldRbghGQJAhYiMvDKqpuhMZOS
 XrOWZqNYhwPJXkaGai7c2LnNnAs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb475a1.7f3170606ea0-smtp-out-n05;
 Thu, 07 May 2020 20:54:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16C17C432C2; Thu,  7 May 2020 20:54:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB7F2C433F2;
        Thu,  7 May 2020 20:54:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 May 2020 13:54:56 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: Replace zero-length array with flexible-array
In-Reply-To: <20200507041127.GA31587@embeddedor>
References: <20200507041127.GA31587@embeddedor>
Message-ID: <bbb33f11e8aaf6d482f923aee22aca39@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-06 21:11, Gustavo A. R. Silva wrote:
[...]
>  static inline struct htt_stats_conf_item *htt_stats_conf_next_item(
> @@ -1674,7 +1674,7 @@ struct htt_tx_fetch_ind {
>  	__le16 num_resp_ids;
>  	__le16 num_records;
>  	struct htt_tx_fetch_record records[0];
> -	__le32 resp_ids[0]; /* ath10k_htt_get_tx_fetch_ind_resp_ids() */
> +	__le32 resp_ids[]; /* ath10k_htt_get_tx_fetch_ind_resp_ids() */
>  } __packed;
> 
Missed to handle records[0].

-Rajkumar
