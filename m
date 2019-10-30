Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A19DEA75F
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 23:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfJ3Wy2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 18:54:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:5925 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbfJ3Wy1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 18:54:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 15:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,248,1569308400"; 
   d="gz'50?scan'50,208,50";a="198825016"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2019 15:54:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iPwrA-0008dq-3M; Thu, 31 Oct 2019 06:54:24 +0800
Date:   Thu, 31 Oct 2019 06:53:28 +0800
From:   kbuild test robot <lkp@intel.com>
To:     John Crispin <john@phrozen.org>
Cc:     kbuild-all@lists.01.org, Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Subject: Re: [PATCH V9 2/3] mac80211: add hw 80211 encapsulation offloading
 support
Message-ID: <201910310645.yXyzN1Cq%lkp@intel.com>
References: <20191029091304.7330-3-john@phrozen.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xqaxbc2eezzs5new"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029091304.7330-3-john@phrozen.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--xqaxbc2eezzs5new
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi John,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mac80211-next/master]
[cannot apply to v5.4-rc5 next-20191030]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/John-Crispin/mac80211-add-802-11-encapsulation-offloading/20191031-041006
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
   WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file include/linux/reservation.h
   Error: Cannot open file include/linux/reservation.h
   include/linux/spi/spi.h:190: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
   include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:335: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:336: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:142: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:347: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:348: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:494: warning: Function parameter or member 'start' not described in 'amdgpu_vm_pt_first_dfs'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:823: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1285: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2823: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:378: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Function parameter or member 'ih' not described in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1: warning: 'pp_dpm_sclk pp_dpm_mclk pp_dpm_pcie' not found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:132: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:238: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source gpu_info FW provided soc bounding box struct or 0 if not
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:243: warning: Function parameter or member 'soc_bounding_box' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'register_hpd_handlers' not found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'dm_pflip_high_irq' not found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: 'dm_crtc_high_irq' not found
   mm/util.c:1: warning: 'get_user_pages_fast' not found
   mm/slab.c:4215: warning: Function parameter or member 'objp' not described in '__ksize'
   fs/fs-writeback.c:913: warning: Excess function parameter 'nr_pages' description in 'cgroup_writeback_by_id'
   fs/direct-io.c:258: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/libfs.c:496: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
   include/linux/w1.h:277: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   kernel/dma/coherent.c:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
   lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
   lib/genalloc.c:1: warning: 'gen_pool_free' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
   include/linux/bitmap.h:341: warning: Function parameter or member 'nbits' not described in 'bitmap_or_equal'
   include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
   include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
   include/net/mac80211.h:4068: warning: Function parameter or member 'sta_set_txpwr' not described in 'ieee80211_ops'
>> include/net/mac80211.h:830: warning: Enum value 'IEEE80211_TX_CTRL_HW_80211_ENCAP' not described in enum 'mac80211_tx_control_flags'
   include/net/mac80211.h:2019: warning: Function parameter or member 'txpwr' not described in 'ieee80211_sta'
   include/net/cfg80211.h:1185: warning: Function parameter or member 'txpwr' not described in 'station_parameters'
   include/linux/skbuff.h:888: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:233: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:515: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
   include/net/sock.h:2439: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2439: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2063: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   drivers/net/phy/phylink.c:595: warning: Function parameter or member 'config' not described in 'phylink_create'
   drivers/net/phy/phylink.c:595: warning: Excess function parameter 'ndev' description in 'phylink_create'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
   include/drm/drm_modeset_helper_vtables.h:1053: warning: Function parameter or member 'prepare_writeback_job' not described in 'drm_connector_helper_funcs'
   include/drm/drm_modeset_helper_vtables.h:1053: warning: Function parameter or member 'cleanup_writeback_job' not described in 'drm_connector_helper_funcs'
   include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
   include/drm/drm_gem_shmem_helper.h:87: warning: Function parameter or member 'madv' not described in 'drm_gem_shmem_object'
   include/drm/drm_gem_shmem_helper.h:87: warning: Function parameter or member 'madv_list' not described in 'drm_gem_shmem_object'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Enum value 'DPLL_ID_TGL_MGPLL5' not described in enum 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Enum value 'DPLL_ID_TGL_MGPLL6' not described in enum 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Excess enum value 'DPLL_ID_TGL_TCPLL6' description in 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:158: warning: Excess enum value 'DPLL_ID_TGL_TCPLL5' description in 'intel_dpll_id'
   drivers/gpu/drm/i915/display/intel_dpll_mgr.h:342: warning: Function parameter or member 'wakeref' not described in 'intel_shared_dpll'
   Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
   Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
   Error: Cannot open file drivers/gpu/drm/i915/i915_gem_batch_pool.c
   drivers/gpu/drm/i915/i915_drv.h:1129: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source The OA context specific information.
   drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source State of the OA buffer.
   drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Locks reads and writes to all head/tail state
   drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source One 'aging' tail pointer and one 'aged' tail pointer ready to
   drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Index for the aged tail ready to read() data up to.
   drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source A monotonic timestamp for when the current aging tail pointer
   drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source Although we can always read back the head pointer register,
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'pinned_ctx' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'specific_ctx_id' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'specific_ctx_id_mask' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'poll_check_timer' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'poll_wq' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'pollin' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'periodic' not described in 'i915_perf_stream'
   drivers/gpu/drm/i915/i915_drv.h:1207: warning: Function parameter or member 'period_exponent' not described in 'i915_perf_stream'

vim +830 include/net/mac80211.h

abe37c4b84502d Johannes Berg          2010-06-07  807  
af61a165187bb9 Johannes Berg          2013-07-02  808  /**
af61a165187bb9 Johannes Berg          2013-07-02  809   * enum mac80211_tx_control_flags - flags to describe transmit control
af61a165187bb9 Johannes Berg          2013-07-02  810   *
af61a165187bb9 Johannes Berg          2013-07-02  811   * @IEEE80211_TX_CTRL_PORT_CTRL_PROTO: this frame is a port control
af61a165187bb9 Johannes Berg          2013-07-02  812   *	protocol frame (e.g. EAP)
6b127c71fbdd3d Sujith Manoharan       2014-12-10  813   * @IEEE80211_TX_CTRL_PS_RESPONSE: This frame is a response to a poll
6b127c71fbdd3d Sujith Manoharan       2014-12-10  814   *	frame (PS-Poll or uAPSD).
dfdfc2beb0dd7e Sven Eckelmann         2016-01-26  815   * @IEEE80211_TX_CTRL_RATE_INJECT: This frame is injected with rate information
6e0456b5454561 Felix Fietkau          2016-03-03  816   * @IEEE80211_TX_CTRL_AMSDU: This frame is an A-MSDU frame
bb42f2d13ffcd0 Toke Høiland-Jørgensen 2016-09-22  817   * @IEEE80211_TX_CTRL_FAST_XMIT: This frame is going through the fast_xmit path
8828f81ad4a2f4 Rajkumar Manoharan     2019-04-11  818   * @IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP: This frame skips mesh path lookup
af61a165187bb9 Johannes Berg          2013-07-02  819   *
af61a165187bb9 Johannes Berg          2013-07-02  820   * These flags are used in tx_info->control.flags.
af61a165187bb9 Johannes Berg          2013-07-02  821   */
af61a165187bb9 Johannes Berg          2013-07-02  822  enum mac80211_tx_control_flags {
af61a165187bb9 Johannes Berg          2013-07-02  823  	IEEE80211_TX_CTRL_PORT_CTRL_PROTO	= BIT(0),
6b127c71fbdd3d Sujith Manoharan       2014-12-10  824  	IEEE80211_TX_CTRL_PS_RESPONSE		= BIT(1),
dfdfc2beb0dd7e Sven Eckelmann         2016-01-26  825  	IEEE80211_TX_CTRL_RATE_INJECT		= BIT(2),
6e0456b5454561 Felix Fietkau          2016-03-03  826  	IEEE80211_TX_CTRL_AMSDU			= BIT(3),
bb42f2d13ffcd0 Toke Høiland-Jørgensen 2016-09-22  827  	IEEE80211_TX_CTRL_FAST_XMIT		= BIT(4),
8828f81ad4a2f4 Rajkumar Manoharan     2019-04-11  828  	IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP	= BIT(5),
5cd49fe8cbba93 John Crispin           2019-10-29  829  	IEEE80211_TX_CTRL_HW_80211_ENCAP	= BIT(6),
af61a165187bb9 Johannes Berg          2013-07-02 @830  };
af61a165187bb9 Johannes Berg          2013-07-02  831  

:::::: The code at line 830 was first introduced by commit
:::::: af61a165187bb94b1dc7628ef815c23d0eacf40b mac80211: add control port protocol TX control flag

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Johannes Berg <johannes.berg@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--xqaxbc2eezzs5new
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--xqaxbc2eezzs5new--
