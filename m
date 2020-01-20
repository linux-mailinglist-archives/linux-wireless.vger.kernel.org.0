Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6831421DB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2020 04:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgATDFj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Jan 2020 22:05:39 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:51015 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728949AbgATDFj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Jan 2020 22:05:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579489538; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=pDKlWN1fmSHr5fcj3YZdXdbjNkmSj+SU5juSWWTVnxc=;
 b=NmWpj6KZR6oaeoFRqmf3SZGmZXbiwZUqtS+FW9ilGic2Vz8DJsuBcgyyE+IVrzUjaSu7XzXV
 eWaYluiVdlRPYP6PQbRajclQpjbSpN64/HRxYJHfM7cFggx/6aFXvzygb3DZD01zG7H3lH52
 BEd2kTC8aKyYC9EsFi03xiEHn44=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e251900.7efb292b5ca8-smtp-out-n02;
 Mon, 20 Jan 2020 03:05:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C45D0C4479C; Mon, 20 Jan 2020 03:05:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B90EC43383;
        Mon, 20 Jan 2020 03:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 19 Jan 2020 19:05:36 -0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Justin Capella <justincapella@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: add retry mechanism for ath10k_start
In-Reply-To: <CAMrEMU-57qrCP3Kh_cna-QNCBfGu6G3e0Y_0-wg6axq_EuoCcw@mail.gmail.com>
References: <20200117083605.392-1-wgong@codeaurora.org>
 <CAMrEMU-57qrCP3Kh_cna-QNCBfGu6G3e0Y_0-wg6axq_EuoCcw@mail.gmail.com>
Message-ID: <cf38fc446f5228d904bd993cac9cc332@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-19 17:17, Justin Capella wrote:
> Is the same address always used for "struct ath10k *ar = hw->priv" --
> even when driver is stopped / bus errors are encountered? If not this
> could potentially be use after free scenario?
"struct ath10k *ar = hw->priv" will changed only if rmmod 
ath10k_sdio/ath10k_pci/ath10k_ahb...
it will not changed for "ifconfig wlan0 down"
> 
> Most code tries to protect the ->state with the config mutex, might
> need to do that here too
yes, I added conf_mutex to protected the ar->state change in
v2:https://patchwork.kernel.org/patch/11340881/
