Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B65AE4CE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiIFJvl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 05:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbiIFJvg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 05:51:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B517E786CC
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 02:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Dqu5rUufUiV64KWQvdRnmiG6kkNRleAX1CZL4L3NS4Q=;
        t=1662457895; x=1663667495; b=sPuIZDeGLLzmWHkbCBaHAITsX+DxmgnWajYpnQp31XlT6GW
        lPqhB0/PxX90P8pw8mTpzS2Pa8g0WGYA6vGAfdtFrk0Swxth69sO2nTihs2fD8zLl24jo4tLBVO2R
        lu7nV6X3/uRg7n06Ri/uyuXzNkIMQdWvn59apefShNSJFsjiaudqS+q8h94WdixYbHrKsMlqccq7z
        t/CX3rIp5e98HAjNIEaGYIjwI9gb+jZ3wrvF/aDZuNjue5v8rJ4CrS8qli6i0dsHPfnmufuXPtcFl
        tCjQk2H7EUwJFqTILVfik/HQiQNMb3kYhsAFH9WQf7w2qv81nIQwJ62dNsmebHdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVVEz-009N0v-10;
        Tue, 06 Sep 2022 11:51:33 +0200
Message-ID: <aa39611150a30c97e15790705b2ceb5690cedfae.camel@sipsolutions.net>
Subject: Re: [PATCH v3 11/12] cfg80211: support for calculating S1G bitrates
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kieran Frewen <kieran.frewen@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com
Date:   Tue, 06 Sep 2022 11:51:32 +0200
In-Reply-To: <20220906044812.7609-12-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
         <20220906044812.7609-12-kieran.frewen@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-09-06 at 16:48 +1200, Kieran Frewen wrote:
>=20
> +warn:
> +	if (!rate->bw && !rate->mcs && !rate->nss)
> +		pr_debug("%s: rx status was not received yet!", __func__);

That part seems ... odd? Why not just warn?

johannes
