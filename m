Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF905AE472
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 11:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiIFJkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 05:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbiIFJkW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 05:40:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B418D42AED
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dzjfff+GygRmWLsFlWyj19mn/kF5tWyrIcl4/wwcdlA=;
        t=1662457220; x=1663666820; b=H+HGBZQeEVOPUkGIeMA64ePgS/mosXOec1w0L5AZ6Tc1VRV
        IKsv0L4HDFvYXVpBo0kEYjfj6vNYrx4AobKThb5ZPoT3GUnUxZiTmpKnSiO5AsCJ2yZsN9vXZR/8z
        +3AZkezFIPOwD2vZ9eS6eExZYYBP7ovfR9iGkHU805uHRDkKwOhvlfij2RzpozsOCk6Ex+iEciUYe
        pLHpiz5KdUmu/ybEQKHN5QErff6L9LlLUSWJsNyXqeXmHm5zNZXUWgaX+x/I++wM3qfvU/nj+l6sX
        XdkrM+I/njQ0Tzo9lXKfxBS8kkRIuiX1J5mxMF9exrfawUgasQhG1ZKsfhOZhIKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVV46-009Mc1-19;
        Tue, 06 Sep 2022 11:40:18 +0200
Message-ID: <95588bd2352048ea0a8016153e1fe7abb26a62e2.camel@sipsolutions.net>
Subject: Re: [PATCH v3 03/12] mac80211: S1G beacon/short beacon support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kieran Frewen <kieran.frewen@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com
Date:   Tue, 06 Sep 2022 11:40:17 +0200
In-Reply-To: <20220906044812.7609-4-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
         <20220906044812.7609-4-kieran.frewen@morsemicro.com>
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
> If configured, use the S1G short beacon format. The S1G short beacon
> format includes a limited set of information elements.

Could you be more specific? Is there really no reason to think that this
limited set might need to be set partially by hostapd?

> -	if (beacon->tail)
> +	if (beacon->tail && !is_short)
>  		skb_put_data(skb, beacon->tail, beacon->tail_len);

Asking since you do this here.

johannes
