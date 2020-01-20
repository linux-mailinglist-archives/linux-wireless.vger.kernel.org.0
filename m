Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB3142648
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2020 09:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgATI5i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 03:57:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37393 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgATI5h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 03:57:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so13823386wmf.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2020 00:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I1F+16kKgPtMMZVMS8otZXdDtI+qugtrGQma3QJHj20=;
        b=LSzzICJ0gnVGeBXM66q8QVe/szJOS2fuUimRkB3iWkskQp7h4lW2Y9H+Mww4D7SFeD
         lcrbyehgoLVLN11dqUaGrGAh4Q4qb7zxdHjU3KY5oBSBQBeBn7tqWI8n0X5fZQ+lIwlw
         I/Mh+kT1CMS/5w8opR4TFzOqR/p7I+5LXpNQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I1F+16kKgPtMMZVMS8otZXdDtI+qugtrGQma3QJHj20=;
        b=EtxqOsFq/mlfOC6e1PcoBDOW0YJPiKUUYmiNXEFSUsrJHhA6aKhGFA2PfWIWfQ8KKn
         5dq2HMzZcckX8mfupRyMiHnnzUOxhgejHBoztz3v3l5aejtSdnheBC64gk5xy26kso3+
         y3maYdtchELSUKMOgdPAifl2r5WnAVuwz40ZaNv8iLzgm07vQRNwP5tJferI1hlTZXxX
         a8ECXWe9xYG/VeLRuyVq+b3w5oCi87DWnCKW0XYmI75hOZnraiLMWOE1TvMTraNLCNr5
         5o+PvEPr9vk43NGCqru9u6IZcnzOA5+pTCCfm5/p0eoRhzeJ3MOcY9ofdP+ocbjU3zIJ
         L6Ag==
X-Gm-Message-State: APjAAAXJi/ZxhzlBteiq/QOZPDyy+Z4q88BuMDpZrHnHV7C4UUuAu80g
        OAP+EeLhKjoeXuIekUZbvVk1cBe7VjeX/8x7PsgSe8zlt+16+oTfXTrlnFH8MeIHHinedj0/PDv
        CfFWM2oSNQUCnmBqQuOlC8r+nfIdAw5kYvGExoc+2e1tqhTLyANeIMZruLOAtgciOu9CAtpn8AA
        MUjz8dUBbOyiQ2KQ==
X-Google-Smtp-Source: APXvYqx8ncB3/W/K0FHiGtzieL9RGXLBOtBzGk83LWhbyduy3R1UrAwGT+hVfa/ZI33+bqEgNwvV6A==
X-Received: by 2002:a1c:1d8c:: with SMTP id d134mr18211691wmd.16.1579510655510;
        Mon, 20 Jan 2020 00:57:35 -0800 (PST)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id b10sm48674058wrt.90.2020.01.20.00.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 00:57:34 -0800 (PST)
Subject: Re: [PATCH v2] cfg80211: Enhance the AKM advertizement to support per
 interface.
To:     Veerendranath Jakkam <vjakkam@codeaurora.org>,
        johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
References: <20191223185255.1009-1-vjakkam@codeaurora.org>
 <20200117113507.13503-1-vjakkam@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <a09e490e-a1e9-b4ec-afbf-438aef816435@broadcom.com>
Date:   Mon, 20 Jan 2020 09:57:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117113507.13503-1-vjakkam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/17/2020 12:35 PM, Veerendranath Jakkam wrote:
> Commit ab4dfa20534e ("cfg80211: Allow drivers to advertise supported AKM
> suites") introduces the support to advertize supported AKMs to userspace.
> 
> This needs an enhancement to advertize the AKM support per interface type,
> specifically for the cfg80211-based drivers that implement SME and use
> different mechanisms to support the AKM's for each interface type (e.g.,
> the support for SAE, OWE AKM's take different paths for such drivers on
> STA/AP mode).
> 
> Add a new nl80211 attribute to provide supported AKMs per interface type
> to userspace.
> 
> This commit aims the same and enhances the earlier mechanism of advertizing
> the AKMs per wiphy. AKMs advertized in akm_suites are default capabilities
> if not advertized for a specific interface type in iftype_akm_suites.
> 
> Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
> ---
> Changelog:
> v1->v2:
>   -Keep advertizing support for AKM suites per wiphy
>   -AKM suites per interface overrides wiphy AKM suites for specific interface
>   -Rename new nl80211 attribute to NL80211_ATTR_IFTYPE_AKM_SUITES
> ---
>   include/net/cfg80211.h       | 22 +++++++++++++++++++-
>   include/uapi/linux/nl80211.h |  6 ++++++
>   net/wireless/nl80211.c       | 39 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index fa027d0d031b..10533dff2102 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -4398,6 +4398,18 @@ struct cfg80211_pmsr_capabilities {
>   	} ftm;
>   };
>   
> +/**
> + * struct wiphy_iftype_akm_suites - supported akm suites per interface type
> + * @iftype: interface type
> + * @akm_suites: points to an array of supported akm suites
> + * @n_akm_suites: number of supported AKM suites
> + */
> +struct wiphy_iftype_akm_suites {
> +	enum nl80211_iftype iftype;

I can imagine certain iftypes could support same suites so maybe good to 
use bitmask of iftypes iso single iftype.

Regards,
Arend

> +	const u32 *akm_suites;
> +	int n_akm_suites;
> +};
> +
