Return-Path: <linux-wireless+bounces-20218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AF0A5D836
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 09:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3EF188D2DE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B643823BE;
	Wed, 12 Mar 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVNNQtEK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FB11DE3A4
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768267; cv=none; b=lqLlX4wgbZ9KCqPRUh0WOo3E/07PsXqAA80mT+0xcqYlJ4vPH3yST9mGpgmvD4YjCvCKlm2DvXgpWCOHaRCmnb7BfftfFcLM6rEHKKflDu2ETU1VK+GlwkimfHzPpbvceiX0PG8W1UqUPYhzVRbvWvrkVX663IzqhcGKdvcGj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768267; c=relaxed/simple;
	bh=hk+yURkq2Gf9MzzsxCEEhTmJESMJrfglduA8GJrOQpw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nw2F+MbX0miUNnalRD7OvJK84MjiwnrNPeGTk7Oz2VlcWKuhzQ4vka9ik4kDujluZG1HF/cWO7n07TkcwSTGDrE2dKqDQmEpedhFswgdXgnazRjpj6xh+yyi2U5twQ/t6qBo09c3B+u18ndjHv1JM3ckR/3YYOX+3MVTRj+386s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CVNNQtEK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso3139598f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 01:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741768264; x=1742373064; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0SgeYPsRnQWwcRb4Y8tKKONrHt2oBoeKB8iGHaWIqNM=;
        b=CVNNQtEKPq4ElxJLnBf9s7duR4PjEcOXl7sCeK9W5/a9rpijDPF8E+qT+xTFHpByNn
         KgHmKGrBtyGcaUyAszwjt4GhNM0dVld1LV8d2v7FYZwzltBejsKP0MWcFje112k8DqFq
         Ks3rv3sz8pCMo5yQazIayXScZQOe83rX8SpLiu/yeDcJKtMx6oodxubTeXl8JhctBNwP
         CH13HI8VYWw3ZnPcngBsHhfwzwoGQktuWcyyft64pc/6IqDg+i0H3MY0ENiv1H0RXLaE
         YS6LsfK5bshDk2OH3TfvjdvBWGDDHBVCxAA5Rusc6bAiSIG/+CbiJ86Ecpk3jVFxcPya
         oSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768264; x=1742373064;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SgeYPsRnQWwcRb4Y8tKKONrHt2oBoeKB8iGHaWIqNM=;
        b=orC099kQ8w34+NnWb6FWk4gdfpRuQSRuGjOImRaIjFsnZFYvRhy7rTLgBHC6VK+hLu
         CG2iKz67Ble+k/xXKM/ZmGt7nLB3y7w4QVnyP3bGGhcnhjUJL6B1LZjekMzAYzyLbOeA
         d/LDP4xcBXUVxixrIJSLr2T69hiQLM/0fYlJZAlKMUA3/JjB5fZAZF3RGAGkv7X0VO80
         m9FqBxg0bmWdVP0XrdDYC3/WU3QSgzafpDUVd/LHSsJ84fkh3mUqCUFWkGVnJ4Ga7qlY
         H7cfoqhzzGVTzrgbrtDhwQY9mdntRgOFMd/bh8ZDQQpAx2ROUz/c12GJcENkLi/m6BII
         bHbA==
X-Gm-Message-State: AOJu0YyklUddxg7MtG3xbHAwvIDJudlo9KTqRNrr2cyBF+8nivK6GLuy
	422+SLJlTz/cGTptLdw/NjIHvohB83iFFWzPKeVttu9srXawCC3ZXjzLRq1YVJ0=
X-Gm-Gg: ASbGncsfKU8LM8yBKpB6ct/T7nsnGIBMKmsEa6sBX2bgbdVWg2iYhk4lwJeLbn0Y6Zu
	ZfMzicL8mucMSBdBMwOc3FwDuRgfeb3hbs7BTd44Y2ELbAB5OJ+Mr8X52uyXgFcgXj+7IlMc3lS
	WCbll88/pv8Khr+BlqUsJUMhR8ClwDWljXuJDqImk2S0t1XumbNEOsLFSQBxMj0gZxV9rIPS+TF
	x/ly3B+Lcch7fJAKrsaRhajFru0CqbxkoQ4+tLLttfRk6ALn7L7J/yX+fuGpMCsr0+KikOC21ZA
	o3pVUPilPgxXS93BGgEkkh6/NHRs0OrwAGCBMJ9oVPcLmVmdsA==
X-Google-Smtp-Source: AGHT+IFBchOjjy0tPxOIO+hvslBGs5cqcV8y0AMqPlXNKWbRrc3BFAJtV0xc2hf+cMSPqvIHEAjclQ==
X-Received: by 2002:a5d:6d8b:0:b0:391:2b04:73d9 with SMTP id ffacd0b85a97d-3926c69b375mr6439525f8f.49.1741768263809;
        Wed, 12 Mar 2025 01:31:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdfcb8sm20714183f8f.33.2025.03.12.01.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:31:03 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:30:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: iwlwifi: add iwlmld sub-driver
Message-ID: <6dc3c2d6-0457-4d2c-9784-b0e5920611c1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Miri Korenblit,

Commit d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver") from Feb
16, 2025 (linux-next), leads to the following Smatch static checker
warning:

	drivers/net/wireless/intel/iwlwifi/mld/d3.c:1978 iwl_mld_wowlan_resume()
	error: uninitialized symbol 'keep_connection'.

drivers/net/wireless/intel/iwlwifi/mld/d3.c
    1884 int iwl_mld_wowlan_resume(struct iwl_mld *mld)
    1885 {
    1886         struct ieee80211_vif *bss_vif;
    1887         struct ieee80211_bss_conf *link_conf;
    1888         struct iwl_mld_netdetect_res netdetect_res;
    1889         struct iwl_mld_resume_data resume_data = {
    1890                 .notifs_expected =
    1891                         IWL_D3_NOTIF_WOWLAN_INFO |
    1892                         IWL_D3_NOTIF_D3_END_NOTIF,
    1893                 .netdetect_res = &netdetect_res,
    1894         };
    1895         int link_id;
    1896         int ret;
    1897         bool fw_err = false;
    1898         bool keep_connection;
    1899 
    1900         lockdep_assert_wiphy(mld->wiphy);
    1901 
    1902         IWL_DEBUG_WOWLAN(mld, "Starting the wowlan resume flow\n");
    1903 
    1904         mld->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
    1905         if (!mld->fw_status.in_d3) {
    1906                 IWL_DEBUG_WOWLAN(mld,
    1907                                  "Device_powered_off() was called during wowlan\n");
    1908                 goto err;
    1909         }
    1910 
    1911         mld->fw_status.in_d3 = false;
    1912         mld->scan.last_start_time_jiffies = jiffies;
    1913 
    1914         bss_vif = iwl_mld_get_bss_vif(mld);
    1915         if (WARN_ON(!bss_vif))
    1916                 goto err;
    1917 
    1918         /* We can't have several links upon wowlan entry,
    1919          * this is enforced in the suspend flow.
    1920          */
    1921         WARN_ON(hweight16(bss_vif->active_links) > 1);
    1922         link_id = bss_vif->active_links ? __ffs(bss_vif->active_links) : 0;
    1923         link_conf = link_conf_dereference_protected(bss_vif, link_id);
    1924 
    1925         if (WARN_ON(!link_conf))
    1926                 goto err;
    1927 
    1928         iwl_fw_dbg_read_d3_debug_data(&mld->fwrt);
    1929 
    1930         if (iwl_mld_fw_needs_restart(mld, bss_vif)) {
    1931                 fw_err = true;
    1932                 goto err;
    1933         }
    1934 
    1935         resume_data.wowlan_status = kzalloc(sizeof(*resume_data.wowlan_status),
    1936                                             GFP_KERNEL);
    1937         if (!resume_data.wowlan_status)
    1938                 return -1;
    1939 
    1940         if (mld->netdetect)
    1941                 resume_data.notifs_expected |= IWL_D3_ND_MATCH_INFO;
    1942 
    1943         ret = iwl_mld_wait_d3_notif(mld, &resume_data, true);
    1944         if (ret) {
    1945                 IWL_ERR(mld, "Couldn't get the d3 notifs %d\n", ret);
    1946                 fw_err = true;
    1947                 goto err;
    1948         }
    1949 
    1950         if (resume_data.d3_end_flags & IWL_D0I3_RESET_REQUIRE) {
    1951                 mld->fw_status.in_hw_restart = true;
    1952                 goto process_wakeup_results;
    1953         }
    1954 
    1955         iwl_mld_update_changed_regdomain(mld);
    1956         iwl_mld_update_mac_power(mld, bss_vif, false);
    1957         iwl_mld_enable_beacon_filter(mld, link_conf, false);
    1958         iwl_mld_update_device_power(mld, false);
    1959 
    1960         if (mld->netdetect)
    1961                 ret = iwl_mld_scan_stop(mld, IWL_MLD_SCAN_NETDETECT, false);
    1962 
    1963  process_wakeup_results:
    1964         if (mld->netdetect) {
    1965                 iwl_mld_process_netdetect_res(mld, bss_vif, &resume_data);
    1966                 mld->netdetect = false;

mld->netdetect is false but keep_connection is uninitialized.

    1967         } else {
    1968                 keep_connection =
    1969                         iwl_mld_process_wowlan_status(mld, bss_vif,
    1970                                                       resume_data.wowlan_status);
    1971 
    1972                 /* EMLSR state will be cleared if the connection is not kept */
    1973                 if (keep_connection)
    1974                         iwl_mld_unblock_emlsr(mld, bss_vif,
    1975                                               IWL_MLD_EMLSR_BLOCKED_WOWLAN);
    1976         }
    1977 
--> 1978         if (!mld->netdetect && !keep_connection)
                                         ^^^^^^^^^^^^^^^
Uninitialized

    1979                 ieee80211_resume_disconnect(bss_vif);
    1980 
    1981         goto out;
    1982 
    1983  err:
    1984         if (fw_err) {
    1985                 mld->trans->state = IWL_TRANS_NO_FW;
    1986                 set_bit(STATUS_FW_ERROR, &mld->trans->status);
    1987         }
    1988 
    1989         mld->fw_status.in_hw_restart = true;
    1990         ret = 1;
    1991  out:
    1992         if (resume_data.wowlan_status) {
    1993                 kfree(resume_data.wowlan_status->wake_packet);
    1994                 kfree(resume_data.wowlan_status);
    1995         }
    1996 
    1997         return ret;
    1998 }

regards,
dan carpenter

