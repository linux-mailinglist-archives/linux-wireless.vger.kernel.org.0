Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB40F78F68
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 17:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbfG2Pee (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 11:34:34 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36138 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387897AbfG2Pee (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 11:34:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so42409373lfc.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FDH1Jn4jahVA3bmYai1a0Gq5r60csCKj2cmxSzZi4PE=;
        b=nAoNeFh4YftXHMw/wWM7kHkczProVHQSiJ5PvJ0nN8/bRse4Fjog4P+deDoM2fnVX4
         Wjh3GwuJPHO1qVl6OWM3n2OQRn26ISLGbILUWNoP4o7DlQEQWMuMiY19UtWbwbeE/Tfk
         jU3gxmsQxh8TA+tYwCHLc/2dSag3d7IU0lDrYfBel0Gs5F8elRJzcbIORleGudRRV1iU
         KnjZC/BXRjYVvluvd1bi4CimsW5wYPyuZydOg4v9duaySxjQLsypkZ+VbhrkcaUB4Rjr
         oYgwBLpedKhykj/3dm/ZUHbVCSOBFAinyJAOkR3bbZ7wKEIJLePC9prFcVx6NEM8qoXW
         ZDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FDH1Jn4jahVA3bmYai1a0Gq5r60csCKj2cmxSzZi4PE=;
        b=f40tNtzRqRQ+XeTEtN/VoaFpX10koR6qEc6FWGmzRpuMWZ0jwhRDC/Pk5ubOKDD4hP
         O0m3xQ5inooVNt9aZD9bSWW4jyWKea/GkKoaYSs5xeQlJOTwlh4pc4nWR6Dq/NbYl0Df
         J2tovJGqfuKxYheBE7Ws/K0qO5jOmymKnlCOmuBUxH1R8JGeyW/WOnNNDlBqAIZLJzXd
         GjgximmWhBFbt/mafItbzqbwrFksYhiXz8D14MHlLiiZs7zmYUXUgNgq7PZP0rKur8e9
         2UUMcXXle8KUCSYFq+ChHkm8FZ4JESlMDZqftgAcfwjjsJ4WIcXo61ahuixnMOrUH0Bq
         I0Iw==
X-Gm-Message-State: APjAAAX4onGoT5fFDHS80sODJeew+diBrHABrK/1/EC4cxK2K2MIG17g
        ClRjVvXJHSTrv84PmtptypE=
X-Google-Smtp-Source: APXvYqyIXNNwb1FlJSnRxpYnQ0z9b8aybCTj0e73zIRBlib5rXUvEwKinMoYUywOm/LxR8f1x3OQPA==
X-Received: by 2002:ac2:4c37:: with SMTP id u23mr37790257lfq.119.1564414471972;
        Mon, 29 Jul 2019 08:34:31 -0700 (PDT)
Received: from [192.168.100.6] ([109.252.54.73])
        by smtp.googlemail.com with ESMTPSA id a18sm12965934ljf.35.2019.07.29.08.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 08:34:31 -0700 (PDT)
Subject: Re: [PATCH v2] cfg80211: use parallel_ops for genl
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <20190729143109.18683-1-johannes@sipsolutions.net>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <fd715fcb-0fa4-6b92-94cb-9c8b7064939e@gmail.com>
Date:   Mon, 29 Jul 2019 10:20:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729143109.18683-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/29/19 9:31 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Over time, we really need to get rid of all of our global locking.
> One of the things needed is to use parallel_ops. This isn't really
> the most important (RTNL is much more important) but OTOH we just
> keep adding uses of genl_family_attrbuf() now. Use .parallel_ops to
> disallow this.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Link: https://lore.kernel.org/r/20190726191621.5031-1-johannes@sipsolutions.net
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   net/wireless/nl80211.c | 108 +++++++++++++++++++++++++++++------------
>   1 file changed, 78 insertions(+), 30 deletions(-)
> 

Reviewed-By: Denis Kenzior <denkenz@gmail.com>

Regards,
-Denis

