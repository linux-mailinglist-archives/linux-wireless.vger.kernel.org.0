Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F01E82E245
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfE2Q2a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 12:28:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2Q2a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 12:28:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 898E8606DB; Wed, 29 May 2019 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559147309;
        bh=gWDSvMXq8PTtNST6XRxQu7MBbCp4hBydBgUt6B8bKpE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gjGxxJ1tTiyN0pXCEIy45EYw0bglkcOatjpmgqa5uc/YCL+Fl4GHRUwAD03ec72xp
         zvwoIAujpNVv3dAPBO4sGWFlLgGxU05F6q8ymnSA2Rii5rw6qaEyZ5osBV8ca1TVWj
         m3uuwW3vqjVw44eK0PiFcwBy2hmb2dfQiTLcaX9g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01A466063A;
        Wed, 29 May 2019 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559147308;
        bh=gWDSvMXq8PTtNST6XRxQu7MBbCp4hBydBgUt6B8bKpE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bZTUONI4gRzqNM1VIqeeUDsc9ywGSa1iRzcJwVo5WyhZIMkVj82feV7kDEDagtuug
         D+SpIFXd63LSJn4rq1Gy4zaoq3tx6t0s6rR/+SNplhi5WULxeRnwtH0tpe/zbhDH/P
         HC9a9GRaWMV+JwfnUfUjYHGu1OMTNow12IJ/JJkU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01A466063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>,
        Dan Carpented <dan.carpenter@oracle.com>
Subject: Re: [PATCH 02/10] cfg80211: use BIT_ULL in cfg80211_parse_mbssid_data()
References: <20190529122537.8564-1-luca@coelho.fi>
        <20190529122537.8564-3-luca@coelho.fi>
Date:   Wed, 29 May 2019 19:28:25 +0300
In-Reply-To: <20190529122537.8564-3-luca@coelho.fi> (Luca Coelho's message of
        "Wed, 29 May 2019 15:25:29 +0300")
Message-ID: <87v9xttec6.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Luca Coelho <luciano.coelho@intel.com>
>
> The seen_indices variable is u64 and in other parts of the code we
> assume mbssid_index_ie[2] can be up to 45, so we should use the 64-bit
> versions of BIT, namely, BIT_ULL().
>
> Reported-by: Dan Carpented <dan.carpenter@oracle.com>

s/ted/ter/ :)

-- 
Kalle Valo
