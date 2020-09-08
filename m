Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E355260911
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 05:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgIHDpZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 23:45:25 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:55476
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728327AbgIHDpZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 23:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599536724;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=IDWFpJ/VZTtUGM6BswWbA9uEi5sS2ngTkdJgNhGd7mI=;
        b=o9KNbTQC6m7gpLm/5HC+khYpBxDpN+xeM0G6NXk/W/xoTq7hW8NqxKOJoRKF0XPk
        xD5WxMbboU1eRhJ++Cri06eWS63A/qxuKx8ZQIWltNSPr5ND7uuu1+ZE37/3Xx0+ndr
        edli4h/HqiXoDIH5rEKsdARdApempfI4KnksYxpU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599536724;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=IDWFpJ/VZTtUGM6BswWbA9uEi5sS2ngTkdJgNhGd7mI=;
        b=jpBzSsJjDE/tX9ZawAYWKXnDxDxulMRPasQXgCm1mjFqbsHuMLDQZV4w50eMv3AG
        2q0aK95FKiDmYE+ZOugS8ymH4S8awC6uJFuHeOMnMXUvDuZDQYX+OaIsV2PdnS2SWeP
        YEgKga16E6cYJRXa32v+tgF4buchH44QOCQ6cKBg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 8 Sep 2020 03:45:24 +0000
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] ath10k: add flag to protect napi operation to avoid
 dead loop hang
In-Reply-To: <87d02x1rqb.fsf@codeaurora.org>
References: <1598617348-2325-1-git-send-email-wgong@codeaurora.org>
 <87d02x1rqb.fsf@codeaurora.org>
Message-ID: <010101746bd17931-91e48596-fbf9-4746-b2bd-a033e7d64568-000000@us-west-2.amazonses.com>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.08-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-08 00:22, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
[...]
> Just like with the recent firmware restart patch, isn't 
> ar->napi_enabled
> racy? Wouldn't test_and_set_bit() and test_and_clear_bit() be safer?
> 
> Or are we holding a lock? But then that should be documented with
> lockdep_assert_held().
yes, ath10k_hif_start is only called from ath10k_core_start, it has 
"lockdep_assert_held(&ar->conf_mutex)",
and ath10k_hif_stop is only called from ath10k_core_stop, it also has 
"lockdep_assert_held(&ar->conf_mutex)".
then it will not 2 thread both enter ath10k_hif_start/ath10k_hif_stop 
meanwhile.
