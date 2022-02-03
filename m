Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4A4A840B
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Feb 2022 13:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiBCMrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Feb 2022 07:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiBCMrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Feb 2022 07:47:10 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB983C061714
        for <linux-wireless@vger.kernel.org>; Thu,  3 Feb 2022 04:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cbtXT7vZPdpCpDrg8Wyyd67lGFxzW5DieXnXdkCoFos=;
        t=1643892430; x=1645102030; b=euSrtS53zHIJM4CVHhf64aXGJDLdob92pWRd2Znbl26JgNW
        0/h7aFyUgFjqm83WDcrAyAxjut+AvbP8UjjliA788Sq7PjN3NL6PAhpDUl90UU+ojZr++qiekP7Gq
        7hpEcEceIGRWJJT+nifsPCq+e7JL6AZn8mdek16JRSvvR05M+nGvsL2IwF4Gez2FQcAE8NGqTBPrI
        9nImkflCtEnYGNPXts1QFABkJq/bzzzFKZshJWaGCooD7dD/4iI2mRm9qd9mLk/aOQvnMQRxd4bfU
        ZZG5UFxXMd30ZXtkkAiLQ5zwSdTJoHhWZw+oFV7Oj0htS8A7Eo55Yh05Sxqtegaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nFbW1-00DzCM-4j;
        Thu, 03 Feb 2022 13:47:09 +0100
Message-ID: <3189c4ca8ae154a37d8bb69b7f9043b4ac30bbe5.camel@sipsolutions.net>
Subject: Re: [PATCH 3/6] nl80211: add support to send EHT capabilities from
 userspace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, quic_vikram@quicinc.com,
        quic_alokad@quicinc.com, quic_jiad@quicinc.com,
        quic_periyasa@quicinc.com, quic_msinada@quicinc.com,
        quic_srirrama@quicinc.com
Date:   Thu, 03 Feb 2022 13:47:08 +0100
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
> 

And that's 13, no? You have to support 80 MHz.

johannes
