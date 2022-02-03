Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A6E4A8405
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 13:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiBCMpJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 07:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiBCMpI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 07:45:08 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D4CC061714
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 04:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=h4vIM/t20WR+qcajSzMvAm+4cVTGkHQKsGglSoiNVpU=;
        t=1643892308; x=1645101908; b=h8CD0sQq3KJC7QfIgRon7M+3OBgGJQ1Z/9jOZXrx2hxI9mW
        tKIgjtwX2zOFFtWGWivv2eukih8YfbQQnYpAl+n/P4xKoYKF7y6ZFnHE0RZen1V17IScwBGBKshIx
        1qPDerCham4rd3Jv89rpnpC7T1kRIlL0oIUH4VcJoJgM/Y4U0Gw2j6TPwyWjZw5cvezxhE5HCb4wR
        QEiKhVmebsnUGECny8ZjTY6YL5fGIO6wtAii4m7fDR11p/0pPKSb57MX3QKPOFf+VMsq2Hg1cXUk9
        dVZEReNSb9URsqyiK84ai/tXl7ttWgFoZcVntlVcO177YR2kB8aZF3In1tu4+C8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nFbU1-00Dz6D-RI;
        Thu, 03 Feb 2022 13:45:05 +0100
Message-ID: <5ede1e1ad04b6359eafb658e827abf6a8343355f.camel@sipsolutions.net>
Subject: Re: [PATCH 3/6] nl80211: add support to send EHT capabilities from
 userspace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, quic_vikram@quicinc.com,
        quic_alokad@quicinc.com, quic_jiad@quicinc.com,
        quic_periyasa@quicinc.com, quic_msinada@quicinc.com,
        quic_srirrama@quicinc.com
Date:   Thu, 03 Feb 2022 13:45:04 +0100
In-Reply-To: <1640163883-12696-4-git-send-email-quic_vjakkam@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
         <1640163883-12696-4-git-send-email-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-12-22 at 14:34 +0530, Veerendranath Jakkam wrote:
>  
> +#define NL80211_EHT_MIN_CAPABILITY_LEN           10
> +#define NL80211_EHT_MAX_CAPABILITY_LEN           81
> 

How did you get to 81?

I calculate only 51, based on the assumption that we can only have
NSS==8. Even if you think NSS==16 (which I doubt), I get to 80 only?

johannes
