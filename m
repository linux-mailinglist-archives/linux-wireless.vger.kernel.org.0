Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423AE673D34
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 16:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjASPNY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 10:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjASPNX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 10:13:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E328A677BE
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 07:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=S5m4q1jHPK7uorYj2HjN2hRkRAGXMZXlNK1kFSWYbMo=;
        t=1674141202; x=1675350802; b=eHZMbMEGzLEsD7i9idmoQjmO+5PD2lRiON5meT/2Fwvdxsk
        D3BBPkn9eMEt+Ugby/Zkz/CEgW0rXTTVVnD5z/I85RXSsAYayJWSTFvCygwRN0r6DvzYI0XrucAj8
        M79ZQN4ewWtDBkcxKJpSgkwcLPqH268W9RT39yzYiff7XKQpg/TqmWVFAEj0XS9FG91nSWCRDdLnA
        TpICyMCmo3L+lv5HZL742Bh6xEMaOLfaaXP31C5Yr0TJ5HjlJFaMQNPWE77uSQhad63UcKX5feTcd
        ilEq5oR7bkNZJahADgCaT9ud1C+UXitKI0mXEp9rTolV0P+KPTn+DQxFHc8yJHuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIWbP-006Yb7-10;
        Thu, 19 Jan 2023 16:13:19 +0100
Message-ID: <e281918e9dfefb9f56a4f778be9dd4c8f9f9980b.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: update rx nss for the link sta
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sriram R <quic_srirrama@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 19 Jan 2023 16:13:16 +0100
In-Reply-To: <20230119135223.18224-1-quic_srirrama@quicinc.com>
References: <20230119135223.18224-1-quic_srirrama@quicinc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Please use wifi: prefix in front of the mac80211: prefix. :)

johannes
