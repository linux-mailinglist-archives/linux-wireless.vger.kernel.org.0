Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06844B16B6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 21:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbiBJUI7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 15:08:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiBJUI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 15:08:59 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C132734
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 12:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jD+RMhV3KaIouHHVyAKOaRyzpa/yHcx8xIQy43KCvCk=;
        t=1644523740; x=1645733340; b=uJrE05G/Q5+K7lSZEwAchfHuJOrObxcZJ2EhldxgEcDD7wi
        H/6NGuBj0pAWUtVZ96a+B+c9Mpo1UP2/9vwmdnVWsf+RmBAzP1F2KJR13eSTvPwWCWyPeXpwGMQ5G
        Uwp/BBuBOFUrnoX0mPLjJAC+RJRRrKe4WIOGdR4FJk23D4nVbS3OxlVFGf2RgH6olf3MFRMwx+hj0
        mPwx4uChskpO/yfqM2tjldoWPx1YI/+3RACzyPu6AvqjHJsw1QBhEkWWtfqe1IxdfUObE92nXj6Dk
        ubTJFiSrHfv4V+2ZshuDbhvYI/rc73AnBPUbvYbApqbjSdcNtwdx48Uk5PsnhVQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIFkO-00HDDO-VE;
        Thu, 10 Feb 2022 21:08:57 +0100
Message-ID: <1cea788b1d1b07070db3dc535afc642d87f6f462.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/19] ieee80211: Add EHT (802.11be) definitions
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     quic_vikram@quicinc.com, quic_alokad@quicinc.com,
        quic_jiad@quicinc.com, quic_periyasa@quicinc.com,
        quic_msinada@quicinc.com, quic_srirrama@quicinc.com,
        ilan.peer@intel.com
Date:   Thu, 10 Feb 2022 21:08:55 +0100
In-Reply-To: <20220210201853.5c0f6b7aa09e.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid>
References: <20220210192008.188166-1-johannes@sipsolutions.net>
         <20220210201853.5c0f6b7aa09e.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
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

On Thu, 2022-02-10 at 20:19 +0100, Johannes Berg wrote:
> +
> +static inline bool
> +ieee80211_eht_oper_size_ok(const u8 *data, u8 len)
> +{
> +	const struct ieee80211_eht_oper_elem *elem = (const void *)data;
> 

That needs to be _operation, not _oper_elem, obviously.

Should build then send, not the other way around ;-)

johannes
