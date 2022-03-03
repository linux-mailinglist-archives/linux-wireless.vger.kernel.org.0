Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1504CC872
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 22:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiCCV7d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Mar 2022 16:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbiCCV7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Mar 2022 16:59:33 -0500
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2662E47563
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 13:58:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id EA40E10FDD;
        Thu,  3 Mar 2022 21:58:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id za7Le7GYx8iN; Thu,  3 Mar 2022 21:58:44 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Thu, 03 Mar 2022 23:58:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1646344724; bh=6gpAJx4nlYO+HEzl04OWN68gtODsQblsbFtOXb7WJOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTRyED4CA0cXAtK/wO6ewaVvITdfsI051FFdE6yJhLcIjIolD72RfSTU0RqhcCihC
         YC9jRA89OFi/QyO2J9fU/DjfZyDNxI2C8kJ9slrUcqw21sPCdIs1cZjOCnUZNw6ZsO
         jT+/Mv9qfPPXtnDpB63FSuBB+QGwf92LyzMeKJVV4YTm5OC40Ltj/MwESu30AEDwks
         yjW9TlI9v/6fSrAT16s2X8X/sJ5S5qGtcSObDycDW6U6bgQytKEmpACHoriFVcWXQN
         4c0DBCbIiPUEwJyfevgamGioeWdW3JjUWfze5fCSuC9Inf9HbEUuZYyU79K3U6MeKu
         SH3RCMAK6Z+ew==
Date:   Thu, 3 Mar 2022 23:58:42 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 1/9] Sync include/uapi/linux/nl80211.h with
 mac80211-next.git
Message-ID: <20220303215842.GB33342@w1.fi>
References: <cover.1640014128.git.lorenzo@kernel.org>
 <47673578aceca9726e4ca724eadbccce1c4d67fb.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47673578aceca9726e4ca724eadbccce1c4d67fb.1640014128.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 20, 2021 at 04:48:16PM +0100, Lorenzo Bianconi wrote:
>  src/drivers/driver_nl80211_event.c |   7 +
>  src/drivers/nl80211_copy.h         | 228 +++++++++++++++++++++++++++--
>  2 files changed, 225 insertions(+), 10 deletions(-)

I copy the nl80211_copy.h updates automatically from the kernel
repository whenever patches require new definitions, so this type of
patches are not actually needed in general.

-- 
Jouni Malinen                                            PGP id EFC895FA
