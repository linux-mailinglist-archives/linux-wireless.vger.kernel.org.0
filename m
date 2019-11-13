Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C448CFB155
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 14:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfKMNcC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 08:32:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfKMNcC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 08:32:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A4A9601A3; Wed, 13 Nov 2019 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573651921;
        bh=qwJ2Oo0KqZdd1YXe+mjqkWJ1BrXqxUI5ngVUOeKPA1I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LDRY7wOYa7nSAYqHs8pzeCjK6LvMjjLz91GZt9dr8epdfKYXgY0eVR3Hp4PfElwO9
         eImBccq0v4f+Yrk3oq7HvYuKO9SODZRXdKwjaoS/8MiT5tgZwzLRFlp0Isx3GQUHR1
         gtisuP8219LFpasovMBCo4eNr6QkbK9/VHSK7UDo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-109-196-nat.elisa-mobile.fi [85.76.109.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DB3C60134;
        Wed, 13 Nov 2019 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573651920;
        bh=qwJ2Oo0KqZdd1YXe+mjqkWJ1BrXqxUI5ngVUOeKPA1I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jixMM2UUz84RN1UdsXQkjBCVCp8K2hveVW3eyGz7m+VagqdvAouV/LiZ1F3yrbmXa
         4IGuLmH0tg6E99srUM7D/JfoVlA4mLNq0YyBTECabA9l1sKDWUnmFub6f20qmnlADd
         C9ad05e9eyGxuG0JhA3GFZTA6nWbDRQzpnjg63SA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DB3C60134
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2019-11-13
References: <3bb7b4be7b9011f4f043b84f26657260f7c4ab02.camel@coelho.fi>
Date:   Wed, 13 Nov 2019 15:31:56 +0200
In-Reply-To: <3bb7b4be7b9011f4f043b84f26657260f7c4ab02.camel@coelho.fi> (Luca
        Coelho's message of "Wed, 13 Nov 2019 11:30:30 +0200")
Message-ID: <87imnnx5pv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Here's the second batch of patches intended for v5.4.  This includes the
> last patchset 2 patchsets I sent.  Usual development work.  More
> details about the contents in the tag description.
>
> I pushed these patches to my pending branch when I sent them out and
> kbuildbot reported success.
>
> Please let me know if there are any issues.

I did a test pull and it fails to build for me, error below. I had
'CONFIG_ACPI=y' in the config, in case that makes a difference.

drivers/net/wireless/intel/iwlwifi/mvm/fw.c:683:15: warning: 'struct iwl_mvm_sar_profile' declared inside parameter list will not be visible outside of this definition or declaration
        struct iwl_mvm_sar_profile *profile,
               ^~~~~~~~~~~~~~~~~~~
drivers/net/wireless/intel/iwlwifi/mvm/fw.c: In function 'iwl_mvm_sar_set_profile':
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:688:9: error: dereferencing pointer to incomplete type 'struct iwl_mvm_sar_profile'
  profile->enabled = enabled;
         ^~
drivers/net/wireless/intel/iwlwifi/mvm/fw.c: In function 'iwl_mvm_sar_get_wrds_table':
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:732:48: error: 'struct iwl_mvm' has no member named 'sar_profiles'
  ret = iwl_mvm_sar_set_profile(mvm, table, &mvm->sar_profiles[0],
                                                ^~
drivers/net/wireless/intel/iwlwifi/mvm/fw.c: In function 'iwl_mvm_sar_get_ewrd_table':
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:786:16: error: 'struct iwl_mvm' has no member named 'sar_profiles'
            &mvm->sar_profiles[i + 1],
                ^~
drivers/net/wireless/intel/iwlwifi/mvm/fw.c: In function 'iwl_mvm_sar_get_wgds_table':
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:822:5: error: 'struct iwl_mvm' has no member named 'geo_rev'
  mvm->geo_rev = tbl_rev;
     ^~
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:834:7: error: 'struct iwl_mvm' has no member named 'geo_profiles'
    mvm->geo_profiles[i].values[j] = entry->integer.value;
       ^~
At top level:
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:800:12: warning: 'iwl_mvm_sar_get_wgds_table' defined but not used [-Wunused-function]
 static int iwl_mvm_sar_get_wgds_table(struct iwl_mvm *mvm)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:739:12: warning: 'iwl_mvm_sar_get_ewrd_table' defined but not used [-Wunused-function]
 static int iwl_mvm_sar_get_ewrd_table(struct iwl_mvm *mvm)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/intel/iwlwifi/mvm/fw.c:701:12: warning: 'iwl_mvm_sar_get_wrds_table' defined but not used [-Wunused-function]
 static int iwl_mvm_sar_get_wrds_table(struct iwl_mvm *mvm)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/Makefile.build:265: recipe for target 'drivers/net/wireless/intel/iwlwifi/mvm/fw.o' failed

-- 
Kalle Valo
