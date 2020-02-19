Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1406164B54
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2020 18:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgBSRBg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Feb 2020 12:01:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35143 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBSRBg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Feb 2020 12:01:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so834493otd.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2020 09:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CJIEAXu3uuCQa/23055X/0OthDS4Ab6Y2cXkBTLK9Mc=;
        b=jwzeu1TlYNhB8mWTM1Brue85uAQhigrrfoPK8w7n3z7gdwUe4gWsYa/vQVNjbfM3oy
         FTuGmjO+Hb46jsAktaBrro343K/MHYlFFZ7uWF0LIvTGS5LSTqFspY2YWSrVB2rl5IK+
         VOO/y8LLPdKW3H7jdNvXEAZVNYwcQpyInN8Gif77rbigNqWjkoksxVoEQ55eNGmhtC+K
         mt7g3yAMme9sUnmxa/nbmRhPA6biiDYpEaA2n0yRVcWzCJ1eSEfIN9RAGmRw/T/iYqop
         6byVOz2kVkY1zMP/I2+ujfmIgMJNIsH1nD/oo7jIUA7wZHZdbSv8RWNeFid/aX4Cbmy6
         ELhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CJIEAXu3uuCQa/23055X/0OthDS4Ab6Y2cXkBTLK9Mc=;
        b=G60qZZc/eGsOLueQ8OsSUDzxhvOi3STXmn0JptCBTxJQE4RUs6RV93JGxwLGWzkIXz
         21VUKYFmsfxy47reUizvOTJH2VC9x5HZdMwWZ7IsH/doTDvYc6Qf+/8palIwAC+Y3IGH
         cFieQ/2laYPRLlU64WudCaXeDJisGOhuWdZfZNiE9rFjPxOvxxjEmNecGd0QrA9oBCTS
         Hd/7Qnd+3W84UOtsrZajt/IhscXcfn9/6WoWlVErWj42ACvLgncV9qtrdnoZWWgWoPsy
         qf1utmApfJ7WI7mwDMu7wGep0kaR6Z7JsAQXvc4Gn74E8jck94Gnm/2NWce0wBeYYZGK
         oNOw==
X-Gm-Message-State: APjAAAUSQSfHbzn47uibkUPZnLSyCFcPq95r8ctplhrt7fiEI9bjzxxh
        L+3J8x4Gn5c/wYzyy3jrEik8gniL
X-Google-Smtp-Source: APXvYqzaPqEyo5PiaEAgW5QguIjMRggAQf3Ijx73I3nAnskq1EPV1bKB2F5RQFJupzdk8mARZT/Kxg==
X-Received: by 2002:a9d:4110:: with SMTP id o16mr20471920ote.101.1582131693583;
        Wed, 19 Feb 2020 09:01:33 -0800 (PST)
Received: from [192.168.1.120] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id n17sm96028otq.46.2020.02.19.09.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 09:01:32 -0800 (PST)
Subject: Re: Commit d1d1a96 in rtl8188ee module causes issues when connecting
 to my institute's wifi
To:     Ashish <ashishkumar.yadav@students.iiserpune.ac.in>,
        linux-wireless@vger.kernel.org
References: <4830c992-1a09-9989-ab29-ea403b910551@students.iiserpune.ac.in>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <d36d4847-8e01-e8f0-bf22-9fb53de5861c@lwfinger.net>
Date:   Wed, 19 Feb 2020 11:01:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4830c992-1a09-9989-ab29-ea403b910551@students.iiserpune.ac.in>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/19/20 2:55 AM, Ashish wrote:
> The commit d1d1a96 (at 
> https://github.com/torvalds/linux/commit/d1d1a96bdb4408d02e2bfcb32b71aba165458a80?diff=unified) 
> in rtl8188ee module causes problems while connecting to my institute's wifi. I 
> am not able to connect to that wifi after this commit. The journalctl output is 
> at http://ix.io/28IX (look for "AP off, try to reconnect now").
> 
> The problem is with removal of the struct. Adding the struct back in trx.h 
> solves the issue.
> 

As I have discussed with you in the other venues, that struct was never used, 
and the only way it could have caused any effect is if the alignment of struct 
phy_status_rpt is  critical in some way I do not understand.

Please try the patch below and report back. That will restore the alignment 
without all that mumbo-jumbo about little- vs big-endian.

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h 
b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
index 917729807514..e17f70b4d199 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
@@ -561,6 +561,7 @@ static inline void clear_pci_tx_desc_content(__le32 
*__pdesc, int _size)
          rxmcs == DESC92C_RATE11M)

  struct phy_status_rpt {
+       u8      padding[2];
         u8      ch_corr[2];
         u8      cck_sig_qual_ofdm_pwdb_all;
         u8      cck_agc_rpt_ofdm_cfosho_a;

Larry
