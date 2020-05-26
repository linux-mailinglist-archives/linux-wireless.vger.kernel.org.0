Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A381E1D16
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 10:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgEZISi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZISi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 04:18:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF650C03E97E
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 01:18:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so15217844wru.12
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EAeL65F6dXX/59K0bRjet31Hc9csWuvXV8XECR84d5w=;
        b=WSjPjCCtYUPJ0ED4yQdT5IW8zPY7LIuHP//Q4igD9at0tA50dm5SLhGjnCrS2dWX0r
         eRv59PblE5nkntABs3AxIePpRVA2ZO2qXXZRlhGHn1I2Cn5qc77iCFDcDxpr9BJDHzXU
         8JPeGeVYm9GGWw61OmTL7mgXoqDvZrYwPt0b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EAeL65F6dXX/59K0bRjet31Hc9csWuvXV8XECR84d5w=;
        b=SAe4eJR2ifilDdfLwP0n5e2ZSo/fhREdEU8bIFpIZdgyl6obnmZW+K5/+8bOONuK/d
         Gf6BXuhuZjYSKS8umWkvU5oHOt/b8Q5JL9k2OCLJ046U2xZEUEiqLABtr1fIBSvRa5F5
         YQ205RY2Wtp7luiQDubHSrKGV3kUvprMKJHyWaR0+JUwh7vktr2vMQcXUGybc2+at7A1
         cnnvfaXtoFxXm6PWivL/454LcCk6HcK1jlTv8o7E2ftIQ28T73WC/aqN35jNPiwVqCJi
         DlN+P7HTdJAIBtI49kURmWD7BR4jegr1k2AdNT6n4aPsN7N1rtF3TdsG8+SkRd/mMEK8
         NEMg==
X-Gm-Message-State: AOAM5331v4+FmyaT58dMAY3QNz65T+0VsMXoigwDcBT5lQh+Vw6H3Ovr
        Jv9dWfbrOYk6FIi/hx7Lc7p4uQ==
X-Google-Smtp-Source: ABdhPJzxye9gjPgTiqk9JjKDaSN2yFc8NBOP30DEkkCiyLv7TzhnZSFLTgQ+a33vs7VhDlKOedbrXA==
X-Received: by 2002:adf:a55c:: with SMTP id j28mr15192382wrb.369.1590481116542;
        Tue, 26 May 2020 01:18:36 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id a15sm9283683wra.86.2020.05.26.01.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 01:18:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] nl80211: FILS discovery/bcast probe resp support
To:     Aloka Dixit <alokad@codeaurora.org>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, kbuild test robot <lkp@intel.com>
References: <20200526000913.30434-1-alokad@codeaurora.org>
 <20200526000913.30434-2-alokad@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <0c89ad68-67bf-7ade-7702-1695bb7274cb@broadcom.com>
Date:   Tue, 26 May 2020 10:18:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526000913.30434-2-alokad@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/26/2020 2:09 AM, Aloka Dixit wrote:
> This patch adds new attribute, NL80211_ATTR_FD_BCASTPRESP_CFG
> to configure FILS discovery and broadcast probe response in 6GHz
> for in-band discovery.
> 
> Only one of the two is active at a time to reduce broadcast
> packets over the air.
> 
> Maximum packet interval can be 20 TUs.
> Packet interval set to 0 disables FILS discovery and broadcast
> probe response transmission.
> 
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> Reported-by: kbuild test robot <lkp@intel.com>

huh? what is reported. Oh, guess it is the reason for having v2. Don't 
think this tag is useful for that. Only useful if v1 would have been 
applied and this patch would fix that.

> ---
> v2: Fixed warning.
> 
>   include/net/cfg80211.h       | 26 ++++++++++++++++
>   include/uapi/linux/nl80211.h | 27 +++++++++++++++++
>   net/wireless/nl80211.c       | 58 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 111 insertions(+)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index a82fc59a1d82..e4bc03947005 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -957,6 +957,8 @@ struct cfg80211_crypto_settings {
>    * @assocresp_ies_len: length of assocresp_ies in octets
>    * @probe_resp_len: length of probe response template (@probe_resp)
>    * @probe_resp: probe response template (AP mode only)
> + * @bcast_presp: Broadcast probe response template (AP mode only)
> + * @fils_disc: FILS discovery template (AP mode only)
>    * @ftm_responder: enable FTM responder functionality; -1 for no change
>    *	(which also implies no change in LCI/civic location data)
>    * @lci: Measurement Report element content, starting with Measurement Token
> @@ -965,6 +967,8 @@ struct cfg80211_crypto_settings {
>    *	Token (measurement type 11)
>    * @lci_len: LCI data length
>    * @civicloc_len: Civic location data length
> + * @bcast_presp_len: Broadcast probe response template length
> + * @fils_disc_len: FILS discovery template length
>    */
>   struct cfg80211_beacon_data {
>   	const u8 *head, *tail;
> @@ -974,6 +978,8 @@ struct cfg80211_beacon_data {
>   	const u8 *probe_resp;
>   	const u8 *lci;
>   	const u8 *civicloc;
> +	const u8 *bcast_presp;
> +	const u8 *fils_disc;

This is not really beacon data, now is it?

Regards,
Arend
