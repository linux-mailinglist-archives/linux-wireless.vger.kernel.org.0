Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23B7E43AB
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 16:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjKGPlY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 10:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbjKGPlW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 10:41:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8270FA3
        for <linux-wireless@vger.kernel.org>; Tue,  7 Nov 2023 07:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lURV77Pw5skBmp0sQWdzedgxn/jAstW2MbhYVrLDI4s=;
        t=1699371680; x=1700581280; b=bGoqWFbwQaFQsX8mQosBasQPKjcsRsyjfPe4aV0DPqkyoCs
        hL0vKYeP1OCOtBCcXFBG36YABDahertJdvyv2B7K8ermkS+v2/AeW8TNZGZnyWJWNirg5apwJ90ar
        YQSO9xsSNJVXwL701KhI+huE0Rch7/ku3lNcHDzshydY/UfKV2YeMl1b1ylp1WlUM2YE38y/yYISe
        gI6P76IR0OvV29+hfVDpoZiOQlLEwRPE9Ej5hRv84QVh1ZejBCanlFJOg7zdXHy8/hm3cMytRON3i
        N1jnZb4BgKWbbQVD4zK1m2YMM2kPuTE/fJD1JtvrD6/4e/02xjE47aUoHUcEG4jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0OCb-0000000H0M2-1GkZ;
        Tue, 07 Nov 2023 16:41:17 +0100
Message-ID: <22c0b564fc18fcd4d421d520f94a78bdb644d1e4.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: add missing milliseconds to TUs
 conversion
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Date:   Tue, 07 Nov 2023 16:41:16 +0100
In-Reply-To: <20231107152611.61952-1-dmantipov@yandex.ru>
References: <20231107152611.61952-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-11-07 at 18:26 +0300, Dmitry Antipov wrote:
> Since 'max_delay' and 'duration' of 'struct iwl_time_event_cmd'
> are in TUs rather than milliseconds, add missing 'MSEC_TO_TU()'
> in 'iwl_mvm_protect_session()' and 'iwl_mvm_schedule_csa_period()'.
> Compile tested only.

Well, the function is actually documenting both TUs and ms depending
where you look ;-)

Not sure I'd want to actually change the behaviour here, but maybe clean
up the docs a bit?

It's also only 2.4% off, so ...

johannes
