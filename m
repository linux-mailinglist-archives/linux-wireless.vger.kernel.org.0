Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA5B519E1F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 13:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbiEDLib (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 07:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242064AbiEDLia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 07:38:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63C62BB19
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 04:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0gF/ln1co4aWvsiGoxDwV9of9rIhhhxO3JTSPCE0FuU=;
        t=1651664094; x=1652873694; b=KfHpXJLq3r20xFK4uT4uQ/bQYDltgwxb86UT0OM8fvp6J1p
        eEuv4X1qZ1LJ6BazYRn0HzZ0zBN5CtxqVq4aSqAdD7y8vR+nquGW2rJ+GIQTvZRpP9uAfBAd0cgSG
        aAILDchZbQWJstzXa3mHSnuFTiEMlcS6di0Rj9n89ENSW7wbi5AP8rhGenaT+fmFKhaxj+dEeABF1
        +6Pl+2LFs0DRKYBL8ysb/2bgTt6uG6Qvmnb/wKiymzAw761lKlM9Ncwzl/HDkKvbCFKp47MxU/UHz
        lCiSQFMNnbjro+oXv3SLTD1f4CNZNFUndLdPci3hR+OjpJaGKhtPilVY0acN4HVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmDHQ-0021C7-P6;
        Wed, 04 May 2022 13:34:52 +0200
Message-ID: <75f4b919029c5d0e81f41410f5df85f17378feac.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/3] nl80211: retrieve EHT operation element in AP
 mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 04 May 2022 13:34:51 +0200
In-Reply-To: <20220323225443.13947-2-quic_alokad@quicinc.com>
References: <20220323225443.13947-1-quic_alokad@quicinc.com>
         <20220323225443.13947-2-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-03-23 at 15:54 -0700, Aloka Dixit wrote:
> Add support to retrieve the EHT operation element passed by
> the userspace in the beacon template and store the pointer in
> struct cfg80211_ap_settings to be used by MAC80211.
> 

Same comments on this (though with ieee80211_eht_oper_size_ok)?

Maybe we don't do that for HE today, but that's rather a bug?

johannes
